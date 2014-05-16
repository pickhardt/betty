#
# os_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/lib/os'

# task: os executor unit tests which tests all the functionality
#       coded in os module
describe OS do

  context "find platform name" do
    it "should find the OS it's running on and shows it" do
      OS.interpret "what OS is used"
      OS.success.should eq(true)
    end
  end

end
