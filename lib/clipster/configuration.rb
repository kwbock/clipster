module Clipster
  class Configuration
    attr_accessor :user_class
    attr_accessor :associates_clip_with_user

    def associates_clip_with_user
      @associates_clip_with_user || false
    end

    def user_class
      @user_class.constantize || "User".constanize
    end

    def user_class=(user_class)
      @user_class = user_class
    end
  end
end