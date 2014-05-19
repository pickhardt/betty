module Permissions
  def self.change_owner(command)
    match = command.match(/^(?:make|give)\s+(me|.+)\s+(?:permissions?|ownership|the\s+owner)\s+(?:(?:of|to|for)\s+)?(.+)$/i)
    if match
      is_me = match[1].downcase == 'me'
      who = is_me ? '`whoami`' : match[1]
      what = match[2].strip
      is_this_directory = what == '.' || what.downcase.match(/^(this\s+)?(?:dir(?:ectory)|folder|path)?$/)
      
      {
        :command => "sudo chown #{ is_this_directory ? '-R ' : '' }#{ who } #{ is_this_directory ? '.' : what }",
        :explanation => "Makes #{ is_me ? 'you' : who } the owner of #{ is_this_directory ? 'all the files in the current directory, including subdirectories' : what }."
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    change_owner_command = self.change_owner(command)
    responses << change_owner_command if change_owner_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Permissions",
      :description => 'Manage file \033[34mPermissions\033[0m',
      :usage => ["give me permission to this directory",
      "give anotheruser ownership of myfile.txt"]
    }
    commands
  end
end

$executors << Permissions
