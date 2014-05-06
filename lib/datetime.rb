module Datetime
  def self.interpret(command)
    responses = []
    
    if command.match(/^what\s+time\sis\sit\??$/i) || command.match(/^what\s+is\sthe\stime$/i)
      responses << {
        :command => "date +\"%T\"",
        :explanation => "Gets the current time."
      }
    end

    if command.match(/^what\s+is\s+((today'?s?|the)\s+)?date\??$/i)
      responses << {
        :command => "date +\"%m-%d-%y\"",
        :explanation => "Gets the current date."
      }
    end

    if command.match(/^what\s+month\sis\sit\??$/i)
      responses << {
        :command => "date +%B",
        :explanation => "Gets the current month."
      }
    end

    if command.match(/^what\s+day\s+(of\s+the\s+week\s+)?is\s+it\??$/i) ||
       command.match(/^what\'?s?\s+today$/)
      responses << {
        :command => "date +\"%A\"",
        :explanation => "Gets the day of the week."
      }
    end

    responses
  end
end

$executors << Datetime
