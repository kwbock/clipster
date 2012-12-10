#!/usr/bin/env rake
module Clipster
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Clipster initializer and copies it to your application"

      def copy_initializer
        template "clipster.rb", "config/initializers/clipster.rb"
      end

      def copy_migrations
        rake("clipster:install:migrations")
      end

      def copy_partials
        template "_includes.html.erb", "app/views/clipster/common/_includes.html.erb"
      end
    end
  end
end
