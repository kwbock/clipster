module Clipster
  module ApplicationHelper
    def get_languages
      languages = CodeRay::Scanners.all_plugins
      languages.delete(CodeRay::Scanners::Raydebug)
      languages.delete(CodeRay::Scanners::Debug)

      languages
    end

    def get_language_counts
      Clip.select("language, count(*) as count").group(:language)
    end

    def display_user_text(user)
      user.send(Clipster.config.user_display_attribute)
    end
  end
end
