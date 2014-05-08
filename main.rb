#!/usr/bin/env ruby
#!/usr/bin/env ruby

$URL = 'https://github.com/pickhardt/betty'
$VERSION = '0.1.3'
$executors = []
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file|
  begin
    require file
  rescue Exception => e
    puts "Module #{file} could not be loaded because of "+e
  end
}

BettyConfig.initialize

def get_input_integer(min, max, options={})
  while true
    input = STDIN.gets.strip
    
    if options[:allow_no] && ['n', 'no'].include?(input.downcase)
      return false
    end

    input_integer = input.to_i    
    if input_integer.to_s == input && min <= input_integer && input_integer <= max
      return input_integer
    end

    say "Sorry, please enter an integer between #{ min } and #{ max }#{ options[:allow_no] ? ', or N for no' : '' }."
  end
end

def get_input_y_n
  while true
    case STDIN.gets.strip.downcase
      when 'y', 'yes'
        return true
      when 'n', 'no'
        return false 
    end

    say "Sorry, please enter Y for Yes or N for No."
  end
end

def interpret(command)
  responses = []
  $executors.each do |executor|
    executors_responses = executor.interpret(command)
    responses = responses.concat(executors_responses)
  end
  responses
end

def run(response)  
  if response[:call_before]
    response[:call_before].call
  end

  if response[:say]
    say response[:say]
  end

  if response[:call]
    response[:call].call
  end

  if response[:command]
    say "Running #{ response[:command] }"
    res = `#{response[:command]}`
    puts res
    if BettyConfig.get("speech")
      speak(res)
    end
  end
end

def speak(text)
  if User.has_command?('say')
    system("say \"#{ text }\"") # formerly mpg123 -q
  else
    has_afplay = User.has_command?('afplay')
    has_mpg123 = User.has_command?('mpg123')
    if has_afplay || has_mpg123
      require 'open-uri'
      text = text.split(/ [+-]/)[0]
      text = text.gsub(' ', '%20')
      speech_path = '/tmp/betty_speech.mp3'

      if text != ''
        url = 'http://translate.google.com/translate_tts?tl=en&q=' + text
        open(speech_path, 'wb') do |file|
          file << open(url).read
        end

        if has_afplay 
          system("afplay #{ speech_path }")
        elsif has_mpg123
          system("mpg123 -q #{ speech_path }")
        end

        system("rm #{ speech_path }")
      end
    end
  end
end

def say(phrase, options={})
  my_name = BettyConfig.get("name")
  puts "#{ options[:no_name] ? '' : my_name + ': ' }#{ phrase }"
  if BettyConfig.get("speech")
    speak(phrase)
  end
end

def main(commands)
  command = commands.join(' ')
  responses = interpret(command)
  
  if responses.length == 1
    response = responses[0]
    if response[:ask_first]
      say "I found the command '#{ responses[0][:command] }'"
      say "       #{ responses[0][:explanation] }", :no_name => true
      say "Do you want me to run this? Y/n"
      if get_input_y_n
        run(response)
      end
    else
      run(response)
    end
  elsif responses.length > 1
    say "Okay, I have multiple ways to respond."
    say "Enter the number of the command you want me to run, or N (no) if you don't want me to run any."
    responses.each_with_index do |response, index|
      say "[#{ index + 1 }] #{ response[:command] }", :no_name => true
      say("    #{ response[:explanation] }", :no_name => true) if response[:explanation]
    end
    which_to_run = get_input_integer(1, responses.length, :allow_no => true)
    run(responses[which_to_run - 1]) if which_to_run
  else
    say "Sorry, I don't understand."
  end
end

main(ARGV)
