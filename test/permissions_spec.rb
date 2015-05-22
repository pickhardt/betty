#
# permissions_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/permissions'

# task: permissions executor unit tests which tests all the functionality
#       coded in permissions module
describe "Permissions" do
  context "Change Ownership" do
    it "should give ownership of a file to specified user" do
      command = Permissions.interpret("give me permission to this directory")[0][:command]
      command.should eq("sudo chown -R `whoami` .")

      command = Permissions.interpret("give anotheruser ownership of myfile.txt")[0][:command]
      command.should eq("sudo chown anotheruser myfile.txt")
    end
  end
end
