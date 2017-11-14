require 'micro_profiler/version'

class MicroProfiler
  def self.measure(garbage_collection: true, block: Proc.new)
    new(garbage_collection: garbage_collection).measure(block)
  end

  def initialize(garbage_collection: true)
    @garbage_collection = garbage_collection
  end

  def measure(block)
    starting_memory_usage
    result = block.call
    ending_memory_usage
    print_results

    result
  end

  private

  attr_reader :garbage_collection

  def current_memory_usage
    `ps -o rss= -p #{Process.pid}`.to_i / 1024
  end

  def ending_memory_usage
    @ending_memory_usage ||= current_memory_usage
  end

  def formatted_memory_usage
    format('%d MB', (ending_memory_usage - starting_memory_usage))
  end

  def handle_garbage_collection
    if garbage_collection
      GC.start
    else
      GC.disable
    end
  end

  def print_results
    puts "Memory Usage: #{formatted_memory_usage}"
  end

  def starting_memory_usage
    @starting_memory_usage ||= current_memory_usage
  end
end
