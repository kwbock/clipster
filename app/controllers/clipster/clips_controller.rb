require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clips = Clip.all

      # Get all language's we have syntax for and remove debugging languages.
      @languages = CodeRay::Scanners.all_plugins.map{|lang| lang.title.to_s}
      @languages.delete("CodeRay Token Dump")
      @languages.delete("CodeRay Token Dump Import")
    end

    def list
      #list all or recent clips
    end
  end
end
