require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clips = Clip.all

      @languages = CodeRay::Scanners.all_plugins.map{|lang| lang.plugin_id.to_s}
    end

    def list
      #list all or recent clips
    end
  end
end
