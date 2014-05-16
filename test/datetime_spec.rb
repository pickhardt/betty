#
# datetime_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/lib/datetime'

# task: datetime executor unit tests which tests all the functionality
#       coded in datetime module
describe Datetime do

  context "time or date" do

    it "should shows the current time" do
      Datetime.interpret "what time is it"
      Datetime.success.should eq(true)
    end

    it "should shows todays date" do
      Datetime.interpret "what is todays date"
      Datetime.interpret "whats today"
      Datetime.success.should eq(true)
    end

    it "should shows month" do
      Datetime.interpret "what month is it"
      Datetime.success.should eq(true)
    end

  end

end
