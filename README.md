# MicroProfiler

Did you ever wish you had a Ruby performance profiler with almost no features?

No? Well, if you did, then this is the gem for you!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micro_profiler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_profiler

## Usage
Just wrap the code you want to profile in a block like this:
```ruby
def expensive_method
  array = []
  10000.times do
    string = 'ABC' * 1000
    array.unshift(string)
  end
  array
end

MicroProfiler.measure do
  expensive_method + expensive_method + expensive_method
end
```

And the measurements will print to STDOUT like this:
```
--- Performance Measurements ---
Garbage Collection: Disabled
Memory Usage: 89 MB
Number of Garbage Collection Runs: 4
Time Elapsed: 0.06 seconds
```

By default, garbage collection is disabled. Re-enable it by passing `garbage_collection: true` to `MicroProfiler.measure`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jaysonvirissimo/micro-profiler.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
