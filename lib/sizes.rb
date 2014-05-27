module Sizes
  @command_string = ""

  def self.show_sizes(where)
    #puts "your command: #{@command_string}"
    pipe = IO.popen("du -s -h #{ where } | sort -n")
    while (line = pipe.gets)
        puts line
    end
  end

  def self.size_stuff(command)
    @command_string = command
    match = command.match(/^show\s+(?:size|disk|usage)\s+for\s+(?:file\s+)?(.+)$/i) ||
            command.match(/^what\S*\s+(?:the\s+)?(?:size|space)\s+(?:for|in|of)\s+(?:file\s+)?(.+)$/i)

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
      :description => 'Find file \033[34mSizes\033[0m',
      :usage => ["show size for file myfile.txt",
      "whats the size of ../this/folder",
      "whats the size of this folder"]
    }
    commands
  end
end

$executors << Sizes
