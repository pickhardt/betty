module Process
  
  def self.examples
    puts "list of all processes"
    puts "processes by user root"
    puts "show me my processes matching log"
  end
  
  def self.my_user_id
    my_name=`echo $USER`
    find_user_id my_name
  end

  def self.find_user_id name
    id=`id -u #{name}`
    id.strip
  end
  
  def self.interpret(command)
    responses = []
    
    process_pattern=%r{
      (?# todo <kill>kill\s)
      (show|find|give|me|a|list|of|those|\s)*
      (?<all>all\s)?
      (?<my>my\s)?
      PROCESS(es)?
      (with|for|process|\s)* (id\s(?<process_id>[0-9]+))?
      (for|with|by\s)* (user\s(?<user_id>\w+))?
      ((like|matching|with|pattern|containing|that|which|contain|\s)+ (?<pattern>\w+))?
    }imx
    
    match=process_pattern.match command 
    
    if match  
      command="ps"
      args=""
      args+=" -afx" if match[:all]
      args+=" -U#{ my_user_id }" if match[:my]
      args+=" -U#{ find_user_id(match[:user_id]) }" if match[:user_id]
      args+=" | grep #{ match[:pattern] }" if match[:pattern]
      # args+=" | kill" if match[:kill] #todo
      
        responses << {
          :command => "#{command} #{args}",
          :explanation => "List all processes"
        }
    end

    return responses
  end
end

$executors << Process
