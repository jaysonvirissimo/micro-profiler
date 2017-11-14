require "bundler/setup"
require "micro_profiler"

RSpec.configure do |config|
  config.before { allow($stdout).to receive(:puts) }
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
