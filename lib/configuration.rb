# frozen_string_literal: true

module Duckery
  class Configuration
    attr_writer :variants

    def variants
      @variants ||= []
    end
  end
end
