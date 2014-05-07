module Speech
  require 'json'
  def self.interpret(command)
    responses = []
    if command.match(/^speech\s+on$/i) || command.match(/^speak\s+to\s+me$/)
      $config["speech"] = true
      File.open(ENV['HOME'] + '/.bettyconfig', 'w') { |file| file.write($config.to_yaml) }
      responses << {
        :say => "Speech ON"
      }
    end

    if command.match(/^speech\s+off$/i) || command.match(/^stop\s+speak(ing)?\s+to\s+me$/)
      $config["speech"] = false
      File.open(ENV['HOME'] + '/.bettyconfig', 'w') { |file| file.write($config.to_yaml) }
      responses << {
        :say => "Speech OFF"
      }
    end
    responses
  end
end

$executors << Speech