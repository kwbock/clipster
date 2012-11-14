module Clipster
  class ApplicationController < ActionController::Base
    before_filter :set_current_user

    def index
      render :text => "Welcome 2 Clipster"
    end

    private
      def set_current_user
        begin
          Clip.current_user = current_user unless not Clipster.config.associates_clip_with_user
        rescue Exception => e
          raise "If User assocations have been enabled for Clipster, your application should have a current_user helper defined"
        end
      end
  end
end
