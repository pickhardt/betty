require 'spec_helper'

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

    context "OS" do
      it "should return right OS name on interpret method" do
        responds_with(
          command: "echo 'OS X'",
          explanation: "Show what OS is used."
        )
      end
    end

    it "returns the right OS name on platform_name method" do
      result = OS.platform_name
      expect(result).to eq("OS X")
    end
  end

  context "help" do
    subject { OS.help }

    it "should return right help" do
      responds_with(
        category: "OS",
        description: 'Show \033[34mOS\033[0m name',
        usage: ["show what OS is used"]
      )
    end
  end
end
