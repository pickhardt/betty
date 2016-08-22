require 'spec_helper'

describe 'Fun' do

  context 'undo git add' do
    it { responds_with say: "To undo a single file use\n\ngit reset filespec\n\n\nTo undo ALL files added (i.e. you want to undo git add .) then use\n\ngit reset" }
  end

end
