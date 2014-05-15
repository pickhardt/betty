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
            else argerror()
            end

            oper = matches[2]
            if oper == "plus"
                op = "+"
            elsif oper == "minus"
                op = "-"
            elsif oper == "times"
                op = "*"
            elsif oper == "by"
                op = "/"
            else operror()
            end

            responses << {
                :command => "bc <<< #{arg1}#{op}#{arg2}",
                :explanation => "Calculates #{arg1}#{op}#{arg2}"
            }
        end
        responses
    end


    def self.help
        commands = []
        commands << {
            :category => "Calculate",
            :description => '\033[34mCalculate\033[0m',
            :usage => ["- betty what is 40 plus 2"]
        }
        commands
    end

    def self.argerror
        print "I think you should use numbers. I can't calculate with apples and oranges :(\n"
        exit
    end

    def self.operror
        print "I can't do complex maths yet :(\n"
        exit
    end
end
$executors << Calculate
