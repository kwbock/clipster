require 'coderay'
require 'dynamic_form'
require 'kaminari'

module Clipster
  class Engine < ::Rails::Engine
    isolate_namespace Clipster

    # so we can use rspec generators
    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end

  def self.config (&block)
    @@config ||= Clipster::Configuration.new

    yield @@config if block

    return @@config
  end
end
