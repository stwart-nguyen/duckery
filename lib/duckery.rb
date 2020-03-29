module Duckery
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    yield(configuration) if block_given?
  end
end
