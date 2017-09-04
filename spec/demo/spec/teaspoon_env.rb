unless defined?(Rails)
  ENV['RAILS_ROOT'] = File.expand_path('../../', __FILE__)
  require File.expand_path('../../config/environment', __FILE__)
end

Teaspoon.configure do |config|
  config.suite do |suite|
    suite.use_framework :mocha
    suite.boot_partial = 'boot'
  end

  config.formatters = ['dot']
  config.coverage {}
end