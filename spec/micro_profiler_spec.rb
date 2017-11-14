require 'spec_helper'

RSpec.describe MicroProfiler do
  it 'has a version number' do
    expect(MicroProfiler::VERSION).not_to be nil
  end

  describe 'prints memory usage in megabytes' do
    let(:expected_message) { 'Memory Usage: ' }
    subject do
      MicroProfiler.measure do
        100.times { 'ABC' * 100 }
      end
    end

    it { expect { subject }.to output(/#{expected_message}/).to_stdout }
  end

  xdescribe 'returns the yielded result'
end
