#
# translate_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/translate'

# task: translate executor unit tests which tests all the functionality
#       coded in translate module
describe "Translate" do
  it "should translates a language to another one" do
    Translate.interpret("translate something from English to Spanish")[0][:command].should eq("open https://translate.google.com/#English/Spanish/something")
  end
end
