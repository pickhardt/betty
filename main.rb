#!/usr/bin/env ruby

$URL = 'https://www.my-website-goes-here.com/'
$VERSION = '0.1.0'
$executors = []
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

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
  if response[:say]
    say response[:say]
  end

  if response[:call]
    response[:call].call
  end

  if response[:command]
    say "Running #{ response[:command] }"
    system response[:command]
  end
end

def say(phrase, options={})
  puts "#{ options[:no_name] ? '' : 'Betty: ' }#{ phrase }"
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
    say "Enter the number of the command you want me to run one, or N (no) if you don't want me to run any."
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
