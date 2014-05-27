#
# user_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/user'

# task: user executor unit tests which tests all the functionality
#       coded in user module
describe "User" do
  it "should shows the information related to user running the betty" do
    User.interpret("whats my username")[0][:command].should eq("whoami")

    User.interpret("whats my real name")[0][:command].should eq("finger $(whoami) | sed 's/.*: *//;q'")

    User.interpret("whats my ip address")[0][:command].should eq("ifconfig")

    User.interpret("who else is logged in")[0][:command].should eq("who | cut -f 1 -d ' ' | uniq")

    User.interpret("whats my version of ruby")[0][:command].should eq("ruby --version")
  end
end
