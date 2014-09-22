require 'spec_helper'

describe 'Calculate' do
  context 'what is the square root of 9' do
    it { responds_with :command => "echo 'scale=10;sqrt(9)' | bc", :explanation => "Calculates square root of 9" }
  end

  context 'what is the square of 3' do
    it { responds_with :command => "echo '3^2' | bc", :explanation => "Calculates square of 3" }
  end

  context 'what is 3 to the power of 4' do
    it { responds_with :command => "echo '3^4' | bc", :explanation => "Calculates 3 to the power of 4" }
  end

  context 'what is the 11 percent of 200' do
    it { responds_with :command => "echo 'scale=2;11*200/100' | bc", :explanation => "Calculates 11 percent of 200" }
  end

  context 'what is 3 plus 5' do
    it { responds_with :command => "echo '3+5' | bc", :explanation => "Calculates 3+5" }
  end

  context 'what is 16 mod 5' do
    it { responds_with :command => "echo '16%5' | bc", :explanation => "Calculates 16%5" }
  end
end
