require 'spec_helper'

describe 'User' do

  context 'what version' do
    it { responds_with :say => $VERSION, :explanation => "Gets Betty's version."}      
  end
  context 'what version is openssl' do
    it { responds_with :command => "openssl version", :explanation => "Gets the version of openssl."}      
  end

end