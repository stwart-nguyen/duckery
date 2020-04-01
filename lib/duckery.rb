module Duckery
  def self.prepended(base)
    base.singleton_class.prepend(@class_methods_module)
  end

  def self.configuration
    @configuration ||= Duckery::Configuration.new
  end

  def self.config
    reset_configuration

    yield(configuration) if block_given?

    @class_methods_module = Module.new do
      Duckery.configuration.variants.each do |variant|
        Duckery.variants_count[variant] = []

        define_method variant do |*args|
          Duckery.variants_count[variant].push(name) # Roll call

          super(*args)
        end
      end
    end
  end

  def self.reset_configuration
    @configuration = Duckery::Configuration.new
  end

  def self.variants_count
    @variants_count ||= {}
  end
end
