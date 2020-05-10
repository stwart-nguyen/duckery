# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'duckery'
  s.version     = '0.0.0'
  s.licenses    = 'MIT'
  s.summary     = 'Dectect add-on'
  s.description = 'Much longer explanation of the example!'
  s.authors     = ['Stewart Nguyen']
  s.email       = 'cuongkb3g@gmail.com'
  s.files       = ['lib/duckery.rb', 'lib/configuration.rb']
  s.homepage    = 'https://rubygems.org/gems/duckery'
  s.executables << 'duckery'
  s.add_runtime_dependency 'require_all', '~> 3.0.0'
  s.add_development_dependency 'rspec'
end
