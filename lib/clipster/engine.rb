require 'coderay'
require 'dynamic_form'

module Clipster
  class Engine < ::Rails::Engine
    isolate_namespace Clipster
  end
end
