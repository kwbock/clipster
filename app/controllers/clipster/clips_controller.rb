require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      create
      render 'create'
    end

    def list
      # get all clips, with the newest clip first
      # TODO: look into pagination and any other info
      @clips = Clip.where(:private => false).order('created_at DESC')

      # you have to love the activerelation queries don't you
      # should probably move to one query for performance if that becomes an issue
      # or we have a large clipset
      @clips = @clips.where(:language => params[:lang]) unless params[:lang].nil?
    end
    
    def create
      @clip = Clip.new(params[:clip])
      
      #only do validation if something was actually posted.
      if !params[:clip].nil? && @clip.valid?
        @clip.save
        redirect_to @clip
        return #early return so we don't have else statement
      end
      
      # Get all languages we have syntax for and remove debugging languages.
      @languages = CodeRay::Scanners.all_plugins
      @languages.delete(CodeRay::Scanners::Raydebug)
      @languages.delete(CodeRay::Scanners::Debug)
    end
    
    def show
      @clip = Clip.find(params[:id])
      cr_scanner = CodeRay.scan(@clip.clip, @clip.language)

      # Only show line numbers if its greater than 1
      @clip_div = cr_scanner.div
      @clip_div = cr_scanner.div(:line_numbers => :table) unless cr_scanner.loc <= 1
    end
  end
end
