require 'spec_helper'

describe 'Shutdown' do

  context 'shutdown computer now' do
    it { responds_with command: "sudo shutdown -h now", :explanation => "restart/shutdown system" }
  end

  context 'reboot system in 120 seconds' do
    it { responds_with command: "sudo shutdown -r +2", :explanation => "restart/shutdown system" }
  end

  context 'restart computer at 23:59' do
    it { responds_with command: "sudo shutdown -r 23:59", :explanation => "restart/shutdown system" }
  end

  context 'cancel system shutdown' do
    it { responds_with command: "sudo shutdown -c", :explanation => "cancel system restart/shutdown" }
  end
  
end
