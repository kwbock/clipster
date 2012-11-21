require_dependency "clipster/application_controller"

module Clipster
  class UsersController < ApplicationController
    def index

    end

    def show
      @user = Clipster.config.user_class.find(params[:id])

      @clips = Clip.public.where(:user_id => @user.id).page(params[:page])

      @languages = Clip.select("language, count(*) as count").group(:language)
    end
  end
end
