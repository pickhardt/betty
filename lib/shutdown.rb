module Shutdown
  def self.interpret(command)
    responses = []
    if action = command.match(/^(?:restart|reboot|shutdown)\s+(?:system|computer|pc)\s+?(?:in\s+)?(\d+)?\s*(now|s|sec|secs|second|seconds|m|min|mins|minute|minutes|h|hour|hours)?$/)
      if action[2] == 'now' || action[1] == "0"
        option_when = "now"
      elsif action[1] > "0" && action[2] && action[2].match(/^(s|sec|secs|second|seconds)$/)
        option_when = "+" + (action[1].to_f/60).ceil.to_s
      elsif action[1] > "0" && action[2] && action[2].match(/^(h|hour|hours)$/)
        option_when = "+" + (action[1].to_i*60).to_s
      elsif action[1] > "0"
        option_when = "+" + action[1]
      end
      flags = command.match(/shutdown/) ? '-h' : '-r' ##shutdown or restart
      responses << {
        :command => "sudo shutdown #{flags} #{option_when}",
        :explanation => "restart/shutdown system #{option_when}"
      }
    end
    if command.match(/^(?:restart|reboot|shutdown)\s+(?:system|computer)\s+?(?:at\s+)?(\d{1,2}:\d{1,2})$/)
      shutdown_time = $1
      flags = command.match(/shutdown/) ? '-h' : '-r' ##shutdown or restart
      responses << {
        :command => "sudo shutdown #{flags} #{shutdown_time}",
        :explanation => "restart/shutdown system at #{shutdown_time}"
      }
    end
    if act = command.match(/^(?:shutdown)\s+(?:system|computer|pc)\s+?(?:(when|after)\s+)?(.* || [0123456789])?\s*(exits|exit|completes|finishes|finish)?$/)
      action = act.to_s.split
      request = "sudo shutdown -h now"
      process = action[3] 
      `sudo echo "got root "` #getting root now to avoid getting password prompt later
      puts " *** waiting for #{process} to exit ***"
      puts " (you can minimize this window but don't close it)"
      count = 0
      while true
        processes = `ps -e`
        is_running = processes.scan(process.downcase)
        if is_running.size == 0 && count == 0
          request = "echo \"\nERROR : #{process} is NOT running\""
          conseq = "prevent shutdown accidentally"
          count += 1
          break
        elsif is_running.size == 0 && count != 0
          request = "sudo shutdown -h now"
          conseq = "shutdown system when #{process} exits"
          break
        else is_running.size > 0
        end
        count += 1
        sleep(1)
      end
      responses << {
        :command => "#{request}",
        :explanation => "#{conseq}"
      }
    end
    responses
  end
  def self.help
    commands = []
    commands << {
      :category => "Shutdown",
      :description => 'Shutdown / reboot computer right now or in a future time',
      :usage => ["shutdown computer now", "restart computer in 60 min", "reboot system at 00:01","shutdown computer when wget finishes","shutdown computer when firefox exits"]
    }
    commands

  end
end
$executors << Shutdown
