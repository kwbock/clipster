module Clipster
  module ModelUtilities
    def use_deprecated_primary_key?
      return true unless Rails::VERSION::MAJOR > 3 and Rails::VERSION::MINOR < 2 
      return false
    end
  end
end