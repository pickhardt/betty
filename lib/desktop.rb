module Desktop

  def self.addremove(command)
    matching = command.match(/^(add|increase|remove|subtract|decrease)\s+(v)(ertical|ert)?(\s+)?(desk|desktop)?/i) ||
            command.match(/^(add|increase|remove|subtract|decrease)\s+(h)(orizontal|oriz)?(\s+)?(desk|desktop)?/i)
    action = "Adds or removes"

    if matching
      action = matching[1].strip.downcase
      direction = matching[2].strip
      
      if action == "add" || action == "increase"
        operator = "+"
        action = "Adds"
      elsif action == "remove" || action == "decrease" || action == "subtract"
        operator = "-"
        action = "Removes"
      end
      
      {
        :command => Command.syscmd({
          :linux => "gconftool-2 --get /apps/compiz-1/general/screen0/options/#{ direction }size | awk '{if ($1 > 0) system(\"gconftool-2 --type=int --set /apps/compiz-1/general/screen0/options/#{ direction }size \" $1#{ operator }1)}'",
        }),
        :explanation => "#{ action } a horizontal Desktop."
      }
    end
  end

  def self.interpret(command)
    responses = []
    
    addremove_command = self.addremove(command)
    responses << addremove_command if addremove_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Desktop",
      :description => 'Control \033[34mVirtual Desktops\033[0m',
      :usage => ["add vertical desktop",
      "add horiz desktop",
      "remove v desk"]
    }
    commands
  end
end

$executors << Desktop
