module RockPaperScissors
  def self.interpret(command)
    responses = []
    
    possible_moves = ['rock', 'paper', 'scissors']

    if command.match(/^(rock|paper|scissors)$/)
      user_hand = $1
      betty_hand = possible_moves.fetch(rand(3))
 
      if user_hand == betty_hand
        result = "Tie"
      elsif (user_hand == 'rock' && betty_hand == 'scissors' ) ||
            (user_hand == 'paper' && betty_hand == 'rock') ||
            (user_hand == 'scissors' && betty_hand == 'paper' )
	result = "You won"
      elsif (user_hand == 'scissors' && betty_hand == 'rock') ||
            (user_hand == 'rock' && betty_hand == 'paper') ||
            (user_hand == 'paper' && betty_hand == 'scissors')
	result = "Betty won"
      end
      
      responses << {
        :say => "You got: \e[0;94;49m#{user_hand}\e[0m and Betty got: \e[0;94;49m#{betty_hand}\e[0m ....... #{result}",
        :explanation => "Play rock, paper, scissors with betty"
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "RockPaperScissors",
      :description => 'Play rock, paper, scissors with betty',
      :usage => ["rock", "paper", "scissors"]
    }
    commands
  end
end

$executors <<  RockPaperScissors
