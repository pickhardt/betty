require "rspec"
require_relative "../../main"
require_relative "../../lib/os"

describe 'OS' do

  context "platform name" do
    before(:all) do
      $VERBOSE = nil
      @platform = RUBY_PLATFORM
      RUBY_PLATFORM = 'darwin'
    end

    after(:all) do
      RUBY_PLATFORM = @platform
    end

    it "should return right OS name on interpret method" do

      result = OS.interpret "OS"
      result[0][:command].should eq("echo 'OS X'")
      result[0][:explanation].should eq("Show what OS is used.")

    end

    it "should return right OS name on platform_name method" do

      result = OS.platform_name
      result.should eq("OS X")

    end
   end

   context "help" do
     it "should return right help" do

       result = OS.help
       result[0][:category].should eq("OS")
       result[0][:description].should eq('Show \033[34mOS\033[0m name')
       result[0][:usage].should eq(["show what OS is used"])

     end
   end
  end
