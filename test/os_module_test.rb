require "rspec"
# require_relative "../main"
# require_relative "../lib/os"
# require_relative "test_helper"

describe 'OS' do

  context "find platform name" do
    let(:outstream)  { StringIO.new }

    # before do
    #   # @platform = RUBY_PLATFORMLATFORM
    #   # RUBY_PLATFORM = 'darwin'
    #
    # end
    #
    # after do
    #   RUBY_PLATFORM = @platform
    # end

    it "should show right OS name" do
      puts 'Mac OS'

      # OS.interpret 'OS'
      outstream.string.should include "Mac OS"
      # command = system( "ruby main.rb os" )
      # STDOUT.should_receive(:puts).with("Linux")
      # command.should != 'Linux'

    end
   end

  end
