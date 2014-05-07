module BettyConfig
  require 'yaml'
  
  @@config = {}
  @@default_config = {"name" => "Betty"}
  
  def self.config_object
    @@config.inspect
  end
  
  def self.initialize
    @@config = {}
    if File.exist?(ENV['HOME'] + '/.bettyconfig')
      begin
        config_file_text = File.read(ENV['HOME'] + '/.bettyconfig')
        @@config = YAML.load(config_file_text) || {}
      rescue
        # bad yaml file?
      end
    end
  end
  
  def self.set(name, value)
    @@config[name] = value
    self.save
  end
  
  def self.get(name)
    @@config[name] || @@default_config[name]
  end
  
  def self.save
    File.open(ENV['HOME'] + '/.bettyconfig', 'w') { |file| file.write(@@config.to_yaml) }
  end
  
  def self.interpret(command)
    responses = []
    if command.match(/^(turn\s+)?speech\s+on$/i) || command.match(/^speak\s+to\s+me$/)
      responses << {
        :call_before => lambda { self.set("speech", true) },
        :say => "Speech ON",
      }
    end

    if command.match(/^(turn\s+)?speech\s+off$/i) || command.match(/^stop\s+speak(ing)?\s+to\s+me$/)
      responses << {
        :call_before => lambda { self.set("speech", false) },
        :say => "Speech OFF"
      }
    end

    if command.match(/^(?:set|change|make)\s+(?:your|betty\'?s?)\s+name\s+to\s+(.+)$/i) || command.match(/^stop\s+speak(ing)?\s+to\s+me$/)
      new_name = $1.strip
      responses << {
        :call_before => lambda { self.set("name", new_name) },
        :say => "OK. Call me #{ new_name } from now on."
      }
    end
    
    if command.match(/^what\'?s?(?:\s+is)?\s+your(\s+mother\s+fucking?)?\s+name\??$/i)
      my_name = self.get("name")
      snoop_part = $1 ? 'Snoop Doggy ' : ''
      
      responses << {
        :say => "My name is #{ snoop_part }#{ my_name }."
      }
    end

    responses
  end
end

$executors << BettyConfig