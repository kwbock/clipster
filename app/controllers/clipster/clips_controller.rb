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
    end

    def create
      @clip = Clip.new(params[:clip])

      #only do validation if something was actually posted.
      if !params[:clip].nil? && @clip.valid?
        @clip.user_id = current_user.id unless not Clipster.config.associates_clip_with_user
        @clip.save
        redirect_to @clip
        return #early return so we don't have else statement
      end

      # Get all languages we have syntax for and remove debugging languages.
      @languages = get_languages
    end

    def show
      @clip = Clip.where("url_hash = :id and (expires is null OR expires > :now)",{
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

      cr_scanner = CodeRay.scan(@clip.clip, @clip.language)

      # Only show line numbers if its greater than 1
      @clip_div = cr_scanner.div
      @clip_div = cr_scanner.div(:line_numbers => :table) unless cr_scanner.loc <= 1
    end

    def search
      @clips = Clip.search(params[:search_term])

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
