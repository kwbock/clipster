module Clipster
  class ApplicationController < ActionController::Base
    before_filter :set_current_user

    private
      def set_current_user
        begin
          Clip.current_user = current_user if Clipster.config.associates_clip_with_user
        rescue Exception => e
          raise "If User assocations have been enabled for Clipster, your application should have a current_user helper defined"
        end
      end
  end
end
