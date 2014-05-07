module Speech
  require 'json'
  def self.interpret(command)
    responses = []
    if command.match(/^speech\s+on$/i)
      options = {"speech" => true}
      File.open(ENV['HOME']+'/.bettyconfig', 'w') { |file| file.write(options.to_json) }
      responses << {
        :say => "Speech ON"
      }
    end

    if command.match(/^speech\s+off$/i)
      options = {"speech" => false}
      File.open(ENV['HOME']+'/.bettyconfig', 'w') { |file| file.write(options.to_json) }
      responses << {
        :say => "Speech OFF"
      }
    end
    responses
  end
end

$executors << Speech