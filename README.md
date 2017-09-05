# Amp4e::Components::Rails


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amp4e-components-rails'
```

And then execute:

    $ bundle
    
## Usage

#### Alerts 
> Displays flash messages equivalent to Rails ERB version

```coffeescript
  alert = new AMP4e.Alerts()
  alert.success('some-success-message')
  alert.info('some-info-message')
  alert.warning('some-warning-message')
  alert.error('some-error-message')
  alert.clear()
```

## Testing 
    $ bin/rspec
 
## Demo

> Please check out [demo README](spec/demo) for details.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).