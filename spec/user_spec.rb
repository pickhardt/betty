require 'spec_helper'

describe 'User' do

  context 'what version' do
    it { responds_with :say => $VERSION, :explanation => "Gets Betty's version."}      
  end

end