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
        command: "echo 'scale=10;sqrt(#{arg1})' | bc",
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
        command: "echo '#{arg1}^#{power}' | bc",
        explanation: "Calculates #{power_text} of #{arg1}"
      }
    return responses
    end


    matches = command.match(/^what\s+is\s+(.+)\s+(to\s+the|to\s+the\s+power\s+of|power)\s+(.+)$/) 
    if matches

      if ( matches[1].gsub(/(\s+|to|the|of)/,"").numeric? && matches[3].gsub(/(\s+|to|the|of)/,"").numeric?)
        arg1 = matches[1].gsub(/(\s+|to|the|of)/,"")
        arg3 = matches[3].gsub(/(\s+|to|the|of)/,"")
      else 
        return []
      end
     
      responses << {
        command: "echo '#{arg1}^#{arg3}' | bc",
        explanation: "Calculates #{arg1} to the power of #{arg3}"
      }
    return responses
    end


    matches = command.match(/^what\s+is\s+(?:the\s+)?(.+)\s?(?:%|percent)\s+of\s+(.+)$/)
    if matches

      if ( matches[1].numeric? && matches[2].numeric? )
        arg1 = matches[1].strip
        arg2 = matches[2].strip
      else 
        return []
      end

      responses << {
        command: "echo 'scale=2;#{arg1}*#{arg2}/100' | bc",
        explanation: "Calculates #{arg1} percent of #{arg2}"
      }
    return responses
    end

    matches = command.match(/^what\s+is\s+(.+)\s+choose\s+(.)$/)
    if matches
 
      if (matches[1].numeric? && matches[2].numeric?)
        arg1 = matches[1]
        arg2 = matches[2]
      else 
        return []
      end
      
      responses << {
        command: "echo 'define f (x) { if (x <= 1) return (1); return (f(x-1) * x); } f(#{arg1})/(f(#{arg2})*f(#{arg1}-#{arg2}))' | bc",
        explanation: "Calculates #{arg1} choose #{arg2}"
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
      elsif ["mod", "module", "%"].include?(oper)
        op = "%"
      else
        return []
      end
      
      responses << {
        command: "echo '#{arg1}#{op}#{arg2}' | bc",
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
      usage: ["what is 40 plus 2", 
              "what is the square root of 9", 
              "what is the cube of 3", 
              "what is 3 to the power of 4", 
              "what is the 11 percent of 200", 
              "what is 26 mod 5"]
    }
    commands
  end
end

$executors << Calculate
