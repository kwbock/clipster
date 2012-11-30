require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController

    def clips
      # get all clips, with the newest clip first
      if params[:lang].nil?
        @clips = Clip.public.order('created_at DESC').page(params[:page])
      else
        @clips = Clip.language_for_public(params[:lang]).order('created_at DESC').page(params[:page])
      end

      @updated_at = @clips.first.updated_at unless @clips.empty?

      respond_to do |format|
        format.html
        format.atom
      end
    end

    def new
      @clip = Clip.new()
    end

    def create
      @clip = Clip.new(params[:clip])

      #only do validation if something was actually posted.
      if @clip.valid?
        @clip.save
        redirect_to @clip
        return #early return so we don't have else statement
      end

      render :new # didn't pass validation
    end

    def show
      @clip = Clip.where("id = :id and (expires is null OR expires > :now)",{
          :id => params[:id],
          :now => DateTime.now
      }).first

      if @clip.nil?
        # Most likely the clip is expired, take advantage of this time to
        # clean up all expired clips, then display error page
        Clip.delete_expired
        render :expired
        return
      end
      
      respond_to do |format|
        format.html
        format.text
      end
    end

    def search
      @clips = Clip.search(params[:search_term]).page(params[:page])
      render :clips
    end
  end
end
