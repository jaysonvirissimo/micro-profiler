require 'spec_helper'

RSpec.describe MicroProfiler do
  it "has a version number" do
    expect(MicroProfiler::VERSION).not_to be nil
  end

  xdescribe "prints memory usage in megabytes"

  xdescribe "returns the yielded result"
end
