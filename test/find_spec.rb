#
# find_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/count'

# task: find executor unit tests which tests all the functionality
#       coded in find module
describe "Find" do
  context "find stuff" do
    it "should find stuff that user asks for it" do
      command = Find.interpret("find me all files that contain california")[0][:command]
      command.should eq("grep --include=\\* -Rn california .")
    end
  end
end
