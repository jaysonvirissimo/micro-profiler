require 'micro_profiler/version'

class MicroProfiler
  def self.measure(block: Proc.new)
    new.measure(block)
  end

  def initialize; end

  def measure(block)
    starting_memory_usage

    block.call

    ending_memory_usage

    print_results
  end

  private

  def current_memory_usage
    `ps -o rss= -p #{Process.pid}`.to_i / 1024
  end

  def ending_memory_usage
    @ending_memory_usage ||= current_memory_usage
  end

  def formatted_memory_usage
    format('%d MB', (ending_memory_usage - starting_memory_usage))
  end

  def print_results
    puts "Memory Usage: #{formatted_memory_usage}"
  end

  def starting_memory_usage
    @starting_memory_usage ||= current_memory_usage
  end
end
