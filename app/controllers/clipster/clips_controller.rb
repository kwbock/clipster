require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController

    # GET /clips
    # GET /clips.json
    # GET /clips.xml
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
        format.json { render json: @clips }
        format.xml { render xml: @clips }
      end
    end

    # GET /new
    # GET /new.json
    # GET /new.xml
    def new
      @clip = Clip.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @clip }
        format.xml { render xml: @clip }
      end
    end

    # POST /
    def create
      @clip = Clip.new(params[:clip])
      
      respond_to do |format|
        if @clip.valid? && @clip.save
          format.html { redirect_to @clip }
          format.json { render json: @clip, status: :created, location: @post }
          format.xml { render xml: @clip, status: :created, location: @post }
        else# didn't pass validation
          format.html { render :new }
          format.json { render json: @clip.errors, status: :unprocessable_entity }
          format.xml { render xml: @clip.errors, status: :unprocessable_entity }
        end
      end
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

    def preview
      @clip = Clip.new(params[:clip])
      render :partial => 'clipster/common/clip', :object => @clip
    end
  end
end
