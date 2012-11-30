module Clipster
  module ApplicationHelper
    def supported_languages
      languages = CodeRay::Scanners.all_plugins
      languages.delete(CodeRay::Scanners::Raydebug)
      languages.delete(CodeRay::Scanners::Debug)

      languages.sort{ |x,y| x.title <=> y.title } # sort by language title
    end

    def language_counts
      Clip.select("language, count(*) as count").public.group(:language)
    end

    def display_user_text(user)
      user.send(Clipster.config.user_display_attribute)
    end
  end
end
