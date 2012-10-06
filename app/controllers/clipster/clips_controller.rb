require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clip = Clip.new
      
      # Get all language's we have syntax for and remove debugging languages.
      @languages = CodeRay::Scanners.all_plugins.map{|lang| lang.title.to_s}
      @languages.delete("CodeRay Token Dump")
      @languages.delete("CodeRay Token Dump Import")
    end

    def list
      #list all or recent clips
    end
    
    def create
      @clip = Clip.new(params[:clip])
      @clip.save
      redirect_to(@clip)
    end
    
    def show
      @clip = Clip.find(params[:id])
    end
  end
end
