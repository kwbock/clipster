require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clip = Clip.new
      
      # Get all language's we have syntax for and remove debugging languages.
      @languages = CodeRay::Scanners.all_plugins
      @languages.delete(CodeRay::Scanners::Raydebug)
      @languages.delete(CodeRay::Scanners::Debug)
    end

    def list
      #list all or recent clips
    end
    
    def create
        @clip = Clip.new(params[:clip])
        if @clip.valid?
          @clip.save
          redirect_to(@clip)
        else
          # Get all language's we have syntax for and remove debugging languages.
          @languages = CodeRay::Scanners.all_plugins
          @languages.delete(CodeRay::Scanners::Raydebug)
          @languages.delete(CodeRay::Scanners::Debug)
          render "index"
        end
    end
    
    def show
      @clip = Clip.find(params[:id])
    end
  end
end
