#
# count_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/count'

# task: count executor unit tests which tests all the functionality
#       coded in count module
describe "Count" do
  context "count stuff" do
    it "should count the total number of files located in specified location" do
      command = Count.interpret("how many words are in this directory")[0][:command]
      command.should eq("find . -type f -exec wc -w {} \\; | awk '{total += $1} END {print total}'")
    end
  end
end
