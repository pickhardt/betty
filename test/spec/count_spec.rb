require 'rspec'
require_relative '../../main'
require_relative '../../lib/count'

describe Count do
  describe '.count_stuff' do
    subject { described_class.count_stuff(command) }

    context 'with invalid count command' do
      let(:command) { 'unknown command' }
      it { should be_nil }
    end

    context 'with "count (*) in (*)" pattern' do
      let(:command) { 'count words in file' }
      it { should_not be_nil }
    end

    context 'with "how many (*) are in (*)" pattern' do
      let(:command) { 'how many words are in file' }
      it { should_not be_nil }
    end
  end

  describe '.what_to_count' do
    subject { described_class.what_to_count(what) }

    context 'with words' do
      let(:what) { 'words' }
      it { should eq('words') }
    end

    context 'with chars' do
      let(:what) { 'char' }
      it { should eq('characters') }
    end
  end

  describe '.extract_flag' do
    subject { described_class.extract_flag(what) }
    let(:what) { 'words' }

    it { should eq('w') }
  end

  describe '.current_directory?' do
    subject { described_class.current_directory?(where) }

    context 'without matching' do
      let(:where) { 'some/directory/structure' }
      it { should be_falsy }
    end

    context 'with "." directory' do
      let(:where) { '.' }
      it { should be_truthy }
    end

    context 'with verbose description of directory' do
      let(:where) { 'this directory' }
      it { should be_truthy }
    end
  end
end
