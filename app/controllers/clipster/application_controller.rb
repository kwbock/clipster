module Clipster
  class ApplicationController < ActionController::Base
    before_filter :set_current_user

    def index
      render :text => "Welcome 2 Clipster"
    end

    private
      def set_current_user
        Clip.current_user = current_user
      end
  end
end
