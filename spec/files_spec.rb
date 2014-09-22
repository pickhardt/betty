require 'spec_helper'

describe 'Files' do
  context 'Copy myfile.txt to mycopy.txt' do
    it { responds_with command: "cp myfile.txt mycopy.txt",
                       explanation: "Copies the file/folder" }
  end
  
  context 'copy folder mysongs/ to backup/' do
    it { responds_with command: "cp mysongs/ backup/",
                       explanation: "Copies the file/folder" }
  end
end
