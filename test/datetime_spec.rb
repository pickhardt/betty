#
# datetime_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/datetime'

# task: datetime executor unit tests which tests all the functionality
#       coded in datetime module
describe Datetime do

  context "time" do
    it "should shows the current time" do
      command = Datetime.interpret("what time is it")[0][:command]
      command.should eq("date +\"%T\"")
    end
  end

  context "date" do
    it "should shows todays date" do
      command = Datetime.interpret("what is todays date")[0][:command]
      command.should eq("date +\"%m-%d-%y\"")

      command = Datetime.interpret("whats today")[0][:command]
      command.should eq("date +\"%A\"")
    end

    it "should shows month" do
      command = Datetime.interpret("what month is it")[0][:command]
      command.should eq("date +%B")
    end
  end

end
