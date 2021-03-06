require 'micro_profiler/version'
require 'benchmark'

class MicroProfiler
  TIME_PRECISION = 2

  def self.measure(garbage_collection: false, block: Proc.new)
    new(garbage_collection: garbage_collection).measure(block: block)
  end

  def initialize(garbage_collection: false)
    @garbage_collection = garbage_collection
  end

  def measure(result: nil, block: Proc.new)
    calling_method
    before
    self.time = Benchmark.realtime { result = block.call }
    after

    print_measurements
    result
  end

  private

  attr_accessor :time
  attr_reader :garbage_collection

  def after
    ending_memory_usage
    ending_garbage_collection_count
  end

  def before
    starting_garbage_collection_count
    starting_memory_usage
  end

  def calling_method
    @calling_method ||= "##{caller_locations[2].label}:#{caller_locations[2].lineno}"
  end

  def current_garbage_collection_count
    GC.stat[:count].to_i
  end

  def current_memory_usage
    `ps -o rss= -p #{Process.pid}`.to_i / 1024
  end

  def ending_garbage_collection_count
    @ending_garbage_collection_count ||= current_garbage_collection_count
  end

  def ending_memory_usage
    @ending_memory_usage ||= current_memory_usage
  end

  def formatted_memory_usage
    format('%d MB', (ending_memory_usage - starting_memory_usage))
  end

  def garbage_collection_runs
    ending_garbage_collection_count - starting_garbage_collection_count
  end

  def handle_garbage_collection
    if garbage_collection
      GC.start
    else
      GC.disable
    end
  end

  def print_measurements
    puts '--- Performance Measurements ---'
    puts "Calling Method: #{calling_method}"
    puts "Garbage Collection: #{garbage_collection ? 'Enabled' : 'Disabled'}"
    puts "Memory Usage: #{formatted_memory_usage}"
    puts "Number of Garbage Collection Runs: #{garbage_collection_runs}"
    puts "Time Elapsed: #{time.round(TIME_PRECISION)} seconds"
  end

  def starting_garbage_collection_count
    @starting_garbage_collection_count ||= current_garbage_collection_count
  end

  def starting_memory_usage
    @starting_memory_usage ||= current_memory_usage
  end
end
