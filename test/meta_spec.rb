#
# meta_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/meta'

# task: meta executor unit tests which tests all the functionality
#       coded in meta module
describe "Meta" do
  context "betty's version" do
    it "should shows betty version" do
      command = Meta.interpret("what version are you")[0][:say]
      command.should eq("0.1.5")

      command = Meta.interpret("version")[0][:say]
      command.should eq("0.1.5")
    end

    it "should shows betty website" do
      command = Meta.interpret("url")[0][:say]
      command.should eq("https://github.com/pickhardt/betty")

      command = Meta.interpret("website")[0][:say]
      command.should eq("https://github.com/pickhardt/betty")
    end
  end
end
