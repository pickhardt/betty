module BettyConfig
  require 'yaml'
  
  @@config = {}
  @@default_config = {"name" => "Betty","speech"=>false,"speaker"=>"","web"=>false,"chat"=>false}
  
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
    
    # todo: merge all turn ... on|off commands
    if command.match(/^(turn|switch|the|\s)*speech\s+on$/i) || command.match(/^speak\s+to\s+me$/)
      if self.get("speaker").empty?
        speaker_available = self.set_speaker
      else
        speaker_available = true
      end

      if speaker_available
        responses << {
          :call_before => lambda { self.set("speech", true) },
          :say => "Speech ON",
        }
      else
        responses << {
          :say => "Something's wrong with my throat, I can't speak (the program 'say' would help me fix this)."
        }
      end
    end

    if command.match(/^(turn|switch|the|\s)*speech\s+off$/i) || command.match(/^stop\s+speak(ing)?\s+to\s+me$/)
      responses << {
        :call_before => lambda { self.set("speech", false) },
        :say => "Speech OFF"
      }
    end
    
    if command.match(/^(turn|switch|the|\s)*web(\s*mode)?\s+on$/i) || command.match(/^use\s(the\s)?internet$/)
      responses << {
        :call_before => lambda { self.set("web", true) },
        :say => "Web queries ON",
      }
    end

    if command.match(/^(turn|switch|the|\s)*web(\s*mode)?\s+off$/i) || command.match(/^don'?t\suse\s(the\s)?internet$/)
      responses << {
        :call_before => lambda { self.set("web", false) },
        :say => "Web queries OFF"
      }
    end
    
    if command.match(/^(turn|switch|the|\s)*chat(\s*mode)?\s+on$/i) || command.match(/^chat\swith\sme$/)
      responses << {
        :call_before => lambda { self.set("chat", true) },
        :say => "Chatmode ON",
      }
    end

    if command.match(/^(turn|switch|the|\s)*chat(\s*mode)?\s+off$/i) || command.match(/^don'?t\schat\swith\sme$/)
      responses << {
        :call_before => lambda { self.set("chat", false) },
        :say => "Chatmode OFF"
      }
    end
    
    if command.match(/^(list\s(your\s)?voices)/i)
        if User.has_command?('say')
            responses << {
                :command => 'say -v "?"',
                :explanation => 'List the availables voices for text-to-speech.'
            }
        else
            responses << {
                :say => "I don't seem to have a voice at all (the program 'say' would help me get some)."
            }
        end
    end

    if command.match(/^(?:set|change|make)\s+(?:your|betty\'?s?)\s+voice\s+to\s+(.+)$/i)
      new_voice = $1.strip
      responses << {
        :call_before => lambda { self.set("voice", new_voice) },
        :say => "OK. My new voice is #{ new_voice } from now on."
      }
    end

    if command.match(/^what\'?s?(?:\s+is)?\s+your\s+voice\??$/i)
      my_voice = self.get("voice")
      responses << {
        :say => "My voice is setted as #{ my_voice }."
      }
    end

    if command.match(/^(?:set|change|make)\s+(?:your|betty\'?s?)\s+name\s+to\s+(.+)$/i)
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

  def self.help
    commands = []
    commands << {
      :category => "Config",
      :usage => ["change your name to Joe",
      "speak to me",
      "stop speaking to me"]
    }
    commands
  end

  def self.set_speaker
    success = false
    ["say", "spd-say", "mpg123", "afplay"].each do |speaker|
      if User.has_command?(speaker)
        self.set("speaker", speaker)
        success = true
      end
    end
    success
  end
end

$executors << BettyConfig
