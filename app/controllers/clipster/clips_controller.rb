require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      create
      render 'create'
    end

    def list
      # get all clips, with the newest clip first
      if params[:lang].nil?
        @clips = Clip.public.order('created_at DESC').page(params[:page])
      else
        @clips = Clip.language_for_public(params[:lang]).order('created_at DESC').page(params[:page])
      end

      @languages = Clip.public.select("language, count(*) as count").group(:language)
      @updated_at = @clips.first.updated_at unless @clips.empty?

      respond_to do |format|
        format.html
        format.atom
      end
    end

    # TODO: refactor to do proper RESTful controller
    def new
      create
      render 'create'
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
      @languages = get_languages
    end

    def show
      @clip = Clip.where("id = :id and (expires is null OR expires > :now)",{
          :id => params[:id],
          :now => DateTime.now
      }).first

      if @clip.nil?
        # Most likely the clip is expired, take advantage of this time to
        # clean up all expired clips, then display error page
        Clip.delete_expired_clips
        render :expired
        return
      end
    end

    def search
      @clips = Clip.search(params[:search_term]).page(params[:page])

      p '\n\n\n\n'
      p @clips

      @languages = Clip.select("language, count(*) as count").group(:language)

      render 'list' unless @clips.nil?
    end

    def about
    end

    private

    def get_languages
      languages = CodeRay::Scanners.all_plugins
      languages.delete(CodeRay::Scanners::Raydebug)
      languages.delete(CodeRay::Scanners::Debug)

      languages
    end
  end
end
