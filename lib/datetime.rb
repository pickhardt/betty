module Datetime
  def self.interpret(command)
    responses = []
    
    if command.match(/^((what[s]?)|which)\s+(is\s+)?(the\s)?\s*time(\s+is\s+it)?(\s+now)?\??$/i)
      responses << {
        :command => "date +\"%r (%T)\"",
        :explanation => "Gets the current time."
      }
    end

    if command.match(/^what[s]?\s+(is\s)?\s*(the\s)?\s*(date)?\s*(today)?\s*\??$/i)
      responses << {
        :command => "date +\"%a %d %b, %Y\"",
        :explanation => "Gets the current date."
      }
    end

    if command.match(/^what[s]?\s+(is\s)?\s*(the\s)?\s*month(\s+((is\s+)?(it\s*)?(now)?))?\s*\??$/i)
      responses << {
        :command => "date +%B",
        :explanation => "Gets the current month."
      }
    end

    if command.match(/^((what[s]?)|which)\s+((is\s+)?\s*(the\s)?)?\s*(to|week)?day(\s+(of\s+the\s+week\s*)?(is\s)?\s*(it)?\s?(today|now)?)?\??$/i)
      responses << {
        :command => "date +\"%A\"",
        :explanation => "Gets the day of the week."
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Datetime",
      :description => 'Show information about \033[34mDatetime\033[0m',
      :usage => ["what time is it",
      "what is todays date",
      "what month is it",
      "whats today"]
    }
    commands
  end
end

$executors << Datetime
