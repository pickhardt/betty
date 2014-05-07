module Translate
  def self.interpret(command)
    responses = []
    matches = command.match(/^(?:translate\s+)?(.+)(?:from\s+)(.+)(?:to\s+)(.+)$/)

    if matches
      translate_string = matches[1].gsub(' ', '%20')
      from = matches[2].strip
      to = matches[3].strip

      responses << {
        :command => "open https://translate.google.com.br/##{from}/#{to}/#{translate_string}",
        :explanation => "Opens a browser on Google Translate translating #{translate_string} from #{from} to #{to}."
      }
    end

    responses
  end
end

$executors << Translate
