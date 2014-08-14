class String
  def numeric?
    Float(self) != nil rescue false
  end
end

module Calculate
  def self.interpret(command)
    responses = []
    
    
    matches = command.match(/^what\s+is\s+(?:the\s+)?(?:square\s+root|sqrt)\s+of\s+(.+)$/)
    if matches

      if matches[1].numeric?
        arg1 = matches[1]
      else 
        return []
      end

      responses << {
        command: "bc <<< 'scale=10;sqrt(#{arg1})'",
        explanation: "Calculates square root of #{arg1}"
      }
    return responses
    end


    matches = command.match(/^what\s+is\s+(?:the\s+)?(square|cube)\s+of\s+(.+)$/)
    if matches

      power_text = matches[1]
      if power_text == 'square'
         power = 2
      elsif power_text == 'cube'
         power = 3
      else 
        return []
      end

      if matches[2].numeric?
        arg1 = matches[2]
      else 
        return []
      end
     
      responses << {
        command: "bc <<< #{arg1}^#{power}",
        explanation: "Calculates #{power_text} of #{arg1}"
      }
    return responses
    end
    
    
    matches = command.match(/^what\s+is\s+(.+)\s+(.+)\s(.+)$/)
    if matches
      if (matches[1].numeric? && matches[3].numeric?)
        arg1 = matches[1]
        arg2 = matches[3]
      else 
        return []
      end
      
      oper = matches[2]
      if ["plus", "+"].include?(oper)
        op = "+"
      elsif ["minus", "-"].include?(oper)
        op = "-"
      elsif ["times", "*"].include?(oper)
        op = "*"
      elsif ["by", "divided", "divied by", "/"].include?(oper)
        op = "/"
      else
        return []
      end
      
      responses << {
        command: "bc <<< #{arg1}#{op}#{arg2}",
        explanation: "Calculates #{arg1}#{op}#{arg2}"
      }
    end
    responses
  end
  
  def self.help
    commands = []
    commands << {
      category: "Calculate",
      description: '\033[34mCalculate\033[0m',
      usage: ["- betty what is 40 plus 2", "- betty what is the square root of 123", "- betty what is the cube of 3" ]
    }
    commands
  end
end

$executors << Calculate
