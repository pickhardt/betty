#
# github_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/lib/github'

# task: github executor unit tests which tests all the functionality
#       coded in github module
describe GitHub do

  context "create new repo" do
    it "should create new repo on GitHub" do
      GitHub.create_new_repository "create new repo test on Ch0c0late"
      GitHub.success.should eq(true)
    end
  end

  context "clone a repo" do
    it "should clone an existing repo from GitHub" do
      GitHub.clone_a_repository "clone SourceCodeKit on master from Ch0c0late in ~/Documents"
      GitHub.success.should eq(true)
    end
  end

end
