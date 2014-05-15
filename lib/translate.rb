module Translate
  def self.interpret(command)
    responses = []
    matches = command.match(/^translate\s+(.+)\s+from\s+(.+)?(?:to\s+)(\w+)$/)

    if matches
      translate_string = matches[1].gsub(' ', '%20')
      from = matches[2] || "english"
      from = from.strip
      to = matches[3].strip

      responses << {
        :command => "open https://translate.google.com/##{from}/#{to}/#{translate_string}",
        :explanation => "Opens a browser on Google Translate translating #{translate_string} from #{from} to #{to}."
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Translate",
      :description => '\033[34mTranslate\033[0m',
      :usage =>["- betty translate from en to es"]
    }
    commands
  end
end

$executors << Translate
