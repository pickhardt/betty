#
# os_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/os'

# task: os executor unit tests which tests all the functionality
#       coded in os module
describe OS do

  context "find platform name" do
    it "should find the OS it's running on and shows it" do
      command = OS.interpret("what OS is used")[0][:command]
      command.should eq("echo 'Linux'")
    end
  end

end
