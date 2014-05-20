#
# github_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/github'

# task: github executor unit tests which tests all the functionality
#       coded in github module
describe GitHub do

  context "create new repo" do
    it "should create new repo on GitHub" do
      command = GitHub.interpret("create new repo test on Ch0c0late")[0][:command]
      command.should eq("curl -u 'Ch0c0late' https://api.github.com/user/repos -d '{\"name\":\"test\"}'")
    end
  end

  context "clone a repo" do
    it "should clone an existing repo from GitHub" do
      command = GitHub.interpret("clone SourceCodeKit on master from Ch0c0late in ~/Documents")[0][:command]
      command.should eq("git clone -b master git://github.com/Ch0c0late/SourceCodeKit.git ~/Documents")
    end
  end

end
