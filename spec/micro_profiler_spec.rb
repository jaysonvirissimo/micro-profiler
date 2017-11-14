require 'spec_helper'

RSpec.describe MicroProfiler do
  subject do
    MicroProfiler.measure do
      100.times { 'ABC' * 100 }
    end
  end

  it 'has a version number' do
    expect(MicroProfiler::VERSION).not_to be nil
  end

  it 'defaults to using garbage collection' do
    expect(MicroProfiler.new.send(:garbage_collection)).to be(true)
  end

  describe 'prints memory usage in megabytes' do
    let(:expected_message) { 'Memory Usage: ' }

    it { expect { subject }.to output(/#{expected_message}/).to_stdout }
  end

  xdescribe 'returns the yielded result' 
end
