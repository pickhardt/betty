#
# map_spec.rb
#
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See the license agreement
#

require File.expand_path ".." + '/main.rb'
require File.expand_path ".." + '/lib/map'

# task: map executor unit tests which tests all the functionality
#       coded in map module
describe Map do
  context "show map" do
    it "should show map of where user asked for it" do
      command = Map.interpret("show me a map of mountain view")[0][:command]
      command.should eq("open https://www.google.com/maps/search/mountain%20view")
    end
  end
end
