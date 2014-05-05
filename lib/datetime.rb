module Datetime
  def self.interpret(command)
    responses = []
    
    if command.match(/^what\s+time\sis\sit$/i)
      responses << {
        :command => "date +\"%T\"",
        :explanation => "Gets the current time."
      }
    end

    if command.match(/^what\s+is\sthe\sdate$/i)
      responses << {
        :command => "date +\"%m-%d-%y\"",
        :explanation => "Gets the current date."
      }
    end

    if command.match(/^what\s+month\sis\sit$/i)
      responses << {
        :command => "date +%B",
        :explanation => "Gets the current month."
      }
    end

    if command.match(/^what\s+day\sof\sthe\sweek\sis\sit$/i)
      responses << {
        :command => "date +\"%A\"",
        :explanation => "Gets the day of the week."
      }
    end

    responses
  end
end

$executors << Datetime
