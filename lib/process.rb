module Process
  
  def self.test
    for phrase in examples
      puts "FAILED "+phrase if interpret(phrase).empty?
    end
  end
  
  def self.my_user_id
    my_name=`echo $USER`
    find_user_id my_name
  end

  def self.find_user_id(name)
    id=`id -u #{name}`
    id.strip
  end
  
  def self.interpret(command)
    responses = []
    
    process_pattern=%r{
      (show|find|give|me|a|list|of|those|\s)*
      (?<all>all\s)?
      (?<my>my\s)?
      PROCESS(es)?
      (with|which|that|\s)*
      (for|process|\s)* (id\s(?<process_id>[0-9]+))?
      (for|belonging|belong|to|by|\s)* (user\s(?<user_id>\w+))?
      ((like|matching|with|pattern|containing|that|which|contain|\s)+ (?<pattern>\w+))?
    }imx
    
    # (?# todo <kill>kill\s)
    # (?# regex comments need newer versions of ruby)
    
    match=process_pattern.match command 
    
    if match  
      command="ps"
      args =  ""
      args += " -U#{ my_user_id }"  if match[:my]
      args += " -afx"               if match[:all] and not match[:my] and not match[:user_id]
      args += " -U#{ find_user_id(match[:user_id]) }" if match[:user_id]
      args += " | grep #{ match[:pattern] }"          if match[:pattern]
      # args+=" | kill" if match[:kill] #todo
      
        responses << {
          :command => "#{command} #{args}",
          :explanation => "List all processes"
        }
    end

    return responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Process",
      :description => 'Manipulate a running \033[34mProcess\033[0m',
      :usage => ["list of all processes",
      "processes by user root",
      "show me my processes matching log",
      "show me all processes by root containing grep",
      "show me all my processes containing netbio"]
    }
    commands
  end
end

$executors << Process
