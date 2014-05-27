class String
  def numeric?
    Float(self) != nil rescue false
  end
end

module Calculate
  def self.interpret(command)
    responses = []
    matches = command.match(/^what\s+is\s+(.+)\s+(.+)\s(.+)$/)
    
    if matches
      if (matches[1].numeric? && matches[3].numeric?)
        arg1 = matches[1]
        arg2 = matches[3]
      else 
        responses << {
          say: "I'm sorry, you should use numbers. I can't calculate with apples and oranges."
        }
        return responses
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
        responses << {
          say: "I'm sorry, I can't do complex maths yet."
        }
        return responses
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
      usage: ["- betty what is 40 plus 2"]
    }
    commands
  end
end

$executors << Calculate
