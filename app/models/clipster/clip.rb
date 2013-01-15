module Clipster
  class Clip < ActiveRecord::Base
    include ActionView::Helpers::DateHelper
    extend Clipster::ModelUtilities

    before_create :default_values

    self.primary_key = :id
    set_primary_key :id if self.use_deprecated_primary_key?

    attr_accessible :clip, :language, :title, :private, :expires, :lifespan
    cattr_reader :lifespans
    cattr_accessor :current_user, :lifespan

    belongs_to :user, :class_name => Clipster.config.user_class.to_s if Clipster.config.associates_clip_with_user

    # Define all supported lifespans and their time offset
    @@lifespans = [["Forever", nil],
                   ["An Hour", :hours=>1],
                   ["A Day", :days=>1],
                   ["A Week", :days=>7],
                   ["A Month", :months=>1],
                   ["A Year", :years=>1]]

    validates :clip, :length => {:minimum   => 3}
    validates :title, :length => {:minimum   => 1}
    validates :language, :inclusion => { :in => CodeRay::Scanners.list.map(&:to_s),
          :message => "%{value} is not supported, please choose from: " +
          CodeRay::Scanners.list.map(&:to_s).to_s }
    validates :lifespan, :inclusion => { :in => @@lifespans.flatten,
          :message => "%{value} is not supported, please choose from:" +
          lifespans.map(&:first).to_s}

    # Search all public clips using title, language, and content
    def self.search(term)
      where("(title LIKE :term or language LIKE :term or clip LIKE :term) and (expires is null OR expires > :now)",{
          :term => "#{term}%".gsub('*','%').gsub(/%+/, '%'),
          :now => DateTime.now
      })
    end

    # All clips that are public, language specific, and not expired
    def self.language_for_public(lang)
      where("private = :private AND
             language = :lang AND
             (expires is null OR expires > :now)",{
          :private => false,
          :lang => lang,
          :now  => DateTime.now
      })
    end

    # All clips that are public, and not expired
    def self.public
      where("private = :private AND
             (expires is null OR expires > :now)",{
          :private => false,
          :now  => DateTime.now
      })
    end

    # Setter to convert user's choice of 'A Week', etc. to an actual DateTime
    def lifespan=(lifespan)
      @lifespan = lifespan
      @@lifespans.each_with_index do |span, index|
        if span[0] == lifespan && lifespan != "Forever"
          self.expires = DateTime.now.advance(@@lifespans[index][1])
        end
      end
    end

    def lifespan
      @lifespan
    end

    # Getter to convert an expire date to '1 Month', '1 Year', etc.
    def expires_in_words
      unless self.expires.nil?
        time_ago_in_words(self.expires).humanize
      else
        "The end of time"
      end
    end

    # Utility method called by either cron job or when an expired clip is accessed
    def Clip.delete_expired
      Clip.destroy_all(["expires is not null AND expires <= ?", DateTime.now])
    end

    # Creates the div for the clip
    def div
      cr_scanner = CodeRay.scan(self.clip, self.language)
      # Only show line numbers if its greater than 1
      if cr_scanner.loc <= 1
        return cr_scanner.div
      else
        return cr_scanner.div(:line_numbers => :table)
      end
    end

    protected
      def default_values
        self.user_id = self.current_user if Clipster.config.associates_clip_with_user
        self.id = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      end
  end
end
