module Git
  def self.interpret(command)
    responses = []
    
    if command.match(/^undo\s+git\s+add$/i)
      responses << {
        :say => "To undo a single file use\n\ngit reset filespec\n\n\nTo undo ALL files added (i.e. you want to undo git add .) then use\n\ngit reset"
      }
    end
    
    responses
  end
  
  def self.help
    commands = []
    commands << {
      :category => "Git",
      :usage => ["undo git add"]
    }
    commands
  end
end

$executors << Git