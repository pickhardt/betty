require 'spec_helper'

describe 'RockPaperScissors' do

  context 'rock' do
    it { should 
           include(:explanation => "Play rock, paper, scissors with betty")
       }
  end

end
