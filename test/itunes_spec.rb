#
# itunes_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/itunes'

# task: itunes executor unit tests which tests all the functionality
#       coded in itunes module
describe "iTunes" do
  context "mute and unmute" do
    it "should mute iTunes" do
      command = ITunes.interpret("mute itunes")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to set mute to true'")
    end

    it "should unmute iTunes" do
      command = ITunes.interpret("unmute itunes")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to set mute to false'")
    end
  end

  context "stop the music" do
    it "should stop the music" do
      command = ITunes.interpret("stop the music")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to stop'")
    end

    it "should pause the music" do
      command = ITunes.interpret("pause the music")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to pause'")
    end
  end

  context "start playing" do
    it "should start playing music" do
      command = ITunes.interpret("start the music")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to play'")
    end
  end

  context "change song" do
    it "should play next song" do
      command = ITunes.interpret("next song")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to next track'")
    end

    it "should play previous track" do
      command = ITunes.interpret("prev track")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to previous track'")
    end
  end

  context "what song" do
    it "should shows what song is playing" do
      command = ITunes.interpret("what song is playing")[0][:command]
      command.should eq("osascript -e 'tell application \"iTunes\" to get name of current track'")
    end
  end
end
