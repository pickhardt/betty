#
# count_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/count'

# task: internet executor unit tests which tests all the functionality
#       coded in internet module
describe "Internet" do
  context "download" do
    it "should download the contents of specified URL" do
      command = Internet.interpret("download http://www.mysite.com/something.tar.gz to something.tar.gz")[0][:command]
      command.should eq("curl -o something.tar.gz http://www.mysite.com/something.tar.gz")
    end
  end

  context "uncompress" do
    it "should uncompress the specified file" do
      command = Internet.interpret("uncompress something.tar.gz")[0][:command]
      command.should eq("mkdir something &&  tar -zxvf something.tar.gz -C something")
    end
  end

  context "compress" do
    it "should compress the specified file" do
      command = Internet.interpret("compress /Ch0c0late/Cocoa/")[0][:command]
      command.should eq("cd /Ch0c0late/Cocoa/; tar -czvf /Ch0c0late/Cocoa/.tar.gz *")
    end
  end
end
