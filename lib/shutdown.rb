module Shutdown
  def self.interpret(command)
    responses = []

    if action = command.match(/^(?:restart|reboot|shutdown)\s+(?:system|computer)\s+?(?:in\s+)?(\d+)?\s*(now|s|sec|secs|second|seconds|m|min|mins|minute|minutes|h|hour|hours)?$/)

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
        :explanation => "restart/shutdown system"
      }
    end

    if command.match(/^(?:restart|reboot|shutdown)\s+(?:system|computer)\s+?(?:at\s+)?(\d{1,2}:\d{1,2})$/)

      shutdown_time = $1
      flags = command.match(/shutdown/) ? '-h' : '-r' ##shutdown or restart

      responses << {
        :command => "sudo shutdown #{flags} #{shutdown_time}",
        :explanation => "restart/shutdown system"
      }
    end

    if command.match(/^(?:cancel|abort)\s+(?:system|computer)\s+(?:restart|reboot|shutdown)$/)
      responses << {
        :command => "sudo shutdown -c",
        :explanation => "cancel system restart/shutdown"
      }
    end

    responses
  end


  def self.help
    commands = []
    commands << {
      :category => "Shutdown",
      :description => 'Shutdown / reboot computer right now or in a future time',
      :usage => ["shutdown computer now",
                 "restart computer in 60 min", 
                 "reboot system at 00:01",
                 "abort system shutdown"]
    }
    commands
  end
end

$executors << Shutdown
