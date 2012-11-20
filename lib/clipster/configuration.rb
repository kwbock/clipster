module Clipster
  class Configuration
    attr_accessor :user_class
    attr_accessor :associates_clip_with_user
    attr_accessor :user_display_attribute

    def associates_clip_with_user
      @associates_clip_with_user || false
    end

    def user_class
      @user_class.constantize || "User".constantize
    end

    def user_class=(user_class)
      @user_class = user_class
    end

    def user_display_attribute
      @user_display_attribute || "email"
    end
  end
end