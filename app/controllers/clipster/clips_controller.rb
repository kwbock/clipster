require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clips = Clip.all

      # @languages = CodeRay::Scanners.all_plugins
    end
  end
end
