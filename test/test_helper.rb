require 'stringio'

module TestHelper
  describe 'OutputModule' do
    before do
      $stdout = StringIO.new
    end

    after(:all) do
      $stdout = STDOUT
    end
  end
end
