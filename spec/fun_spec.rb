require 'spec_helper'

describe 'Fun' do

  context 'What is the meaning of life?' do
    it { responds_with say: "42." }
  end

  context 'Open the pod bay doors' do
    it { responds_with say: "I'm sorry, Dave. I'm afraid I can't do that." }
  end

  context 'sudo make me a sandwich' do
    it { responds_with say: "I think you meant to place sudo at the start of the command." }
  end
  
  context "what if batman does not have any kryptonite" do
    it { responds_with say: "Batman always has kryptonite" }
  end

  context "what if batman does not have kryptonite" do
    it { responds_with say: "Batman always has kryptonite" }
  end

end
