module Datetime
  def self.interpret(command)
    responses = []
    
    if command.match(/^what\s+time\sis\sit\??$/i) || command.match(/^what\s+is\sthe\stime$/i) || command.match(/^what\s+is\sthe\stime\snow\??$/i)
      responses << {
        command: "date +\"%T\"",
        explanation: "Gets the current time."
      }
    end

    if command.match(/^what\s+is\s+((today'?s?|the)\s+)?date\??$/i)
      responses << {
        command: "date +\"%m-%d-%y\"",
        explanation: "Gets the current date."
      }
    end

    if command.match(/^what\s+month\sis\sit\??$/i)
      responses << {
        command: "date +%B",
        explanation: "Gets the current month."
      }
    end

    if command.match(/^what\s+day\s+(of\s+the\s+week\s+)?is\s+it\??$/i) ||
       command.match(/^what\'?s?\s+today$/)
      responses << {
        command: "date +\"%A\"",
        explanation: "Gets the day of the week."
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      category: "Datetime",
      description: 'Show information about \033[34mDatetime\033[0m',
      usage: ["- betty what time is it",
      "- betty what is todays date",
      "- betty what month is it",
      "- betty whats today",
      "- betty what is the time now"]
    }
    commands
  end
end

$executors << Datetime
