require 'coderay'
require 'dynamic_form'

module Clipster
  class Engine < ::Rails::Engine
    isolate_namespace Clipster

    # so we can use rspec generators
    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
