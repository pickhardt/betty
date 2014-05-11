module Sizes
  GIGA_SIZE = 1073741824.0
  MEGA_SIZE = 1048576.0
  KILO_SIZE = 1024.0
  @command_string = ""
  
  # Return the file size with a readable style.
  def Sizes.readable_file_size(size, precision)
    case
      when size == 1 
      	return "1 B"
      when size < KILO_SIZE 
      	return "%d B" % size
      when size < MEGA_SIZE 
      	return "%.#{precision}f KB" % (size / KILO_SIZE)
      when size < GIGA_SIZE 
      	return "%.#{precision}f MB" % (size / MEGA_SIZE)
      else 
	return "%.#{precision}f GB" % (size / GIGA_SIZE)
    end
  end
  
  def self.show_sizes(where)
    #puts "your command: #{@command_string}"
  	pipe = IO.popen("du -s #{ where } | sort -n")
	while (line = pipe.gets)
	  match = line.match(/^(\d+)\s+.+?$/)
	  if match
	    puts "#{ Sizes.readable_file_size(match[1].to_i, 2) }    #{ line }"
	  else
	    puts line
	  end
	end
  end

  def self.size_stuff(command)
    @command_string = command
    match = command.match(/^show\s+(?:size|disk|usage)\s+for\s+(.+?)$/i) || command.match(/^what[^\s]*\s+(?:the|)\s*(?:size|space)\s+(?:for|in|of)\s+(.+?)$/i)
    
    if match
      where = match[1].strip
      is_this_directory = where == '.' || where.downcase.match(/^(this\s+)?(?:dir(?:ectory)|folder|path)?$/)
      
      {
        :call => lambda {self.show_sizes(is_this_directory ? '.' : where )},
        :explanation => "Shows the size of files in #{ is_this_directory ? 'all the files in the current directory, including subdirectories' : where }."
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    sizes_command = self.size_stuff(command)
    responses << sizes_command if sizes_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Sizes",
      :description => "Find file \033[34mSizes\033[0m",
      :usage => "- betty show size for file myfile.txt"
    }
    commands
  end
end

$executors << Sizes
