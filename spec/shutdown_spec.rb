require 'spec_helper'

describe 'shutdown' do
    context 'shutdown computer now' do
      it { responds_with command:"sudo shutdown -h now",explanation:"restart/shutdown system now" }
    end

    context 'shutdown computer in 20 min' do
      it { responds_with command:"sudo shutdown -h +20",explanation:"restart/shutdown system +20"}
    end

    context 'shutdown computer at 11:30' do
      it { responds_with command:"sudo shutdown -h 11:30",explanation:"restart/shutdown system at 11:30"}
    end
 
    # # Enable this if you don't mind giving root priviledges to tests

    # context 'shutdown system when NotRunning exits' do
    #   it { responds_with command:"echo \"NotRunning is NOT running\"",explanation:"prevent shutdown accidentally"}
    # end

    # # To enable this test, you need to manually run firefox first, run test, close firefox during test execution

    # context 'shutdown computer when firefox exits' do
    #  it { responds_with command:"sudo shutdown -h now",explanation:"shutdown system when firefox exits"}
    # end
end

