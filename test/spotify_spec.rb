#
# spotify_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/spotify'

# task: spotify executor unit tests which tests all the functionality
#       coded in spotify module
describe "Spotify" do
  context "Start playing" do
    it "should start playing the music" do
      Spotify.interpret("play spotify")[0][:command].should eq("osascript -e 'tell application \"spotify\" to play'")
    end
  end

  context "Pause the music" do
    it "should pause the music that is playing" do
      Spotify.interpret("pause spotify")[0][:command].should eq("osascript -e 'tell application \"spotify\" to pause'")
    end
  end

  context "Change track" do
    it "should play next track" do
      Spotify.interpret("next spotify")[0][:command].should eq("osascript -e 'tell application \"spotify\" to next track'")
    end

    it "should play previous track" do
      Spotify.interpret("prev spotify")[0][:command].should eq("osascript -e 'tell application \"spotify\" to previous track'")
    end
  end
end
