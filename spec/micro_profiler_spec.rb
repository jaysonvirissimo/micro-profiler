require 'spec_helper'

RSpec.describe MicroProfiler do
  subject do
    MicroProfiler.measure do
      thing = []
      1000.times { thing.push('ABC') }
      thing
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

  describe 'prints garbage collection configuration' do
    let(:expected_message) { 'Garbage Collection: Enabled' }

    it { expect { subject }.to output(/#{expected_message}/).to_stdout }
  end

  describe 'prints the number of garbage collection runs' do
    let(:expected_message) { 'Number of Garbage Collection Runs: ' }

    it { expect { subject }.to output(/#{expected_message}/).to_stdout }
  end

  describe 'prints the elapsed time' do
    let(:expected_message) { 'Time Elapsed: ' }

    it { expect { subject }.to output(/#{expected_message}/).to_stdout }
  end

  describe 'returns the yielded result' do
    let(:result) { subject }

    it { expect(result).to be_an(Array) }
    it { expect(result.length).to eq(1000) }
  end
end
