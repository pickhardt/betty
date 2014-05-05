module User  
  def self.interpret(command)
    responses = []
    
    if command.match(/^who\s+am\si$/i) || command.match(/^what\'?s?(\s+is)?\s+my\s(user)?name\??$/i)
      responses << {
        :command => "whoami",
        :explanation => "Gets your system username."
      }
    end
    
    if command.match(/^who\s+am\si$/i) || command.match(/^what\'?s?(\s+is)?\s+my\s((real|full|actual)\s+)?name\??$/i)
      responses << {
        :command => "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'",
        :explanation => "Gets your full name."
      }
    end

    if command.match(/^what\'?s?(\s+is)?(\s+my)?(\s+ip)?\s?(address)?\??$/i)
      responses << {
        :command => "curl ifconfig.me",
        :explanation => "Gets your external ip address."
      }
    end

    if command.match(/^what\'?s?(\s+is)?(\s+version)?(\s+of)?(\s[a-zA-Z]*)?\??$/i)
      program = command.split("version").last
      program = program.split("of").last
      program = program.split("?").first
      program = program.strip

      computerCommand = ""
      case program
      when "python"
        computerCommand = "python -V"
      when "ruby"
        computerCommand = "ruby -v"
      when "node"
        computerCommand = "node --version"
      when "redis"
        computerCommand = "redis-server -v"
      when "mysql"
        computerCommand = "mysql -u root -p -e ' SELECT VERSION(); '"
      when "php"
        computerCommand = "php -v"
      when "mongo" || "mongoDB"
        computerCommand = "mongo --version"
      else
        computerCommand = program + " -v"
      end
      
      responses << {
        :command => computerCommand,
        :explanation => "Gets the version of distribution."
      }
    end
    
    responses
  end
end

$executors << User
