#
# process_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/process'

# task: process executor unit tests which tests all the functionality
#       coded in process module
describe "Process" do
  context "Manipulate a running process" do
    it "should list all the processes" do
      Process.interpret("list of all processes")[0][:command].should eq("ps  -afx")
    end

    it "should list all the processes running by the root user" do
      Process.interpret("processes by user root")[0][:command].should eq("ps  -U0")
    end

    it "should shows matching processes to specified thing running by the user" do
      Process.interpret("show me my processes matching log")[0][:command].should eq("ps  -U503 | grep log")

      Process.interpret("show me all processes by root containing grep")[0][:command].should eq("ps  -afx")

      Process.interpret("show me all my processes containing netbio")[0][:command].should eq("ps  -U503 | grep netbio")
    end
  end
end
