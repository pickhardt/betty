module Fun
  def self.interpret(command)
    responses = []
    
    if command.match(/^what\'?s?(\s+is)?\s+the\s+meaning\s+of\s+life\??$/i)
      responses << {
        :say => "42."
      }
    end
    
    if command.match(/^superman\s+vs\s+batman$/i)
      responses << {
        say: [true,false].sample ? "Batman" : "Superman"
      }
    end

    if command.match(/^what\s+if\s+batman\s+does\snot\s+have\s+a?n?y?\s*kryptonite$/i)
      responses << {
        say: "Batman always has kryptonite"
      }
    end

    
    if command.match(/^open\s(the\s)?pod\sbay\sdoor(s)?$/i)
      responses << {
        :say => "I'm sorry, Dave. I'm afraid I can't do that."
      }
    end
    
    if command.match(/^make\s+me\s+a\s+(.+)$/i)
      thing = "#{ $1 }"
      responses << {
        :call => lambda { self.make_me_a(thing) }
      }
    end
    
    if command.match(/^sudo\s+make\s+me\s+a\s+(.+)$/i)
      responses << {
        :say => "I think you meant to place sudo at the start of the command."
      }
    end
    
    if command.match(/^what\'?s?(\s+is)?\s+my\s(mother\s+fucking?)\s+name\??$/i)
      responses << {
        :say => "Snoop Doggy Dogg."
      }
    end
    
    if command.match(/^you\'?(re)?\s+(are\s+)?(cool|awesome|amazing|fun(ny)?|rock\s+my\s+world|rule)$/i)
      responses << {
        :say => "You betcha."
      }
    end
    
    if command.match(/^go\s+crazy$/i) || command.match(/^trip\s+(out|acid)$/i)
      responses << {
        :call => lambda { self.go_crazy },
        :say => "Woah."
      }
    end
    
    if command.match(/sing (.*)/)
      responses << {
        :command => "say -v cello #{$~}"
      }
    end
    
    responses
  end
  
  def self.make_me_a(thing)
    if Process.uid != 0
      puts "Make your own damn #{thing}."
    else
      puts "Ha, like sudo has any effect on me!"
    end
  end
  
  def self.go_crazy
    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {64000,#{ 64 - i }000,63000,0}\""
    end

    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {#{ 64 - i }000,#{ i }000,63000,0}\""
    end

    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {#{ i }000,63000,#{ 63 - i }000,0}\""
    end
    
    system 'osascript -e "tell application \"Terminal\" to set background color of window 1 to {64000,64000,64000,0}"'
  end

  def self.help
    commands = []
    commands << {
      :category => "Fun",
      :usage => ["go crazy",
      "whats the meaning of life",
      "...and more that are left for you to discover!"]
    }
    commands
  end
end

$executors << Fun
