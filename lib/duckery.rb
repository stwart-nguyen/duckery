# frozen_string_literal: true

require 'configuration'
require 'duckery/railtie' if defined?(Rails)
require 'byebug'

module Duckery
  def self.prepended(base)
    overiden_classes_module =
      Module.new do
        Duckery.configuration.variants.each do |variant|
          Duckery.statistic[base.name] ||= { variants: [] }

          # Lookup on self and ancestor for method `variant`
          next unless base.methods.include?(variant)

          define_method variant do |*args|
            Duckery.statistic[base.name][:variants].push(variant) # Roll call

            super(*args)
          end
        end
      end

    base.singleton_class.prepend(overiden_classes_module)
  end

  def self.configuration
    @configuration ||= Duckery::Configuration.new
  end

  # TODO: convert to symbols
  def self.variants
    configuration.variants
  end

  def self.config
    yield(configuration) if block_given?
  end

  def self.reset_configuration
    @configuration = Duckery::Configuration.new
  end

  def self.statistic
    @statistic ||= {}
  end
end
