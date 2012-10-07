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
          
          # craft url based on url_hash
          # TODO: look for cleaner way to do this as well as the select
          redirect_to :action => "show", :id => @clip.url_hash
          return #early return so we don't have else statement
        end

        # Get all language's we have syntax for and remove debugging languages.
        @languages = CodeRay::Scanners.all_plugins
        @languages.delete(CodeRay::Scanners::Raydebug)
        @languages.delete(CodeRay::Scanners::Debug)
        render "index"
    end
    
    def show
      @clip = Clip.where(:url_hash => params[:id]).first
    end
  end
end
