module Clipster
  class Clip < ActiveRecord::Base
    before_create :init_id
    self.primary_key = :url_hash
    attr_accessible :clip, :language, :title, :private, :expires
    attr_accessor :lifespan
    
    # scope utilized by search functionality.
    # TODO: build more powerful search term creation
    scope :search, lambda {|term| 
      where("title LIKE :term or language LIKE :term or clip LIKE :term",{
          :term => term
      })
    }
    
    validates :clip, :length => {:minimum   => 3}
    validates :title, :length => {:minimum   => 1}
    
    def expires=(lifespan)
      case lifespan
      when "An Hour"
        self.expires = DateTime.advance(:hours=>1)
      when "A Day"
        self.expires = DateTime.advance(:days=>1)
     when "A Month"
        self.expires = DateTime.advance(:months=>1)
      when "A Year"
        self.expires = DateTime.advance(:years=>1)
      end
    end
    
    private
      def init_id
        self.url_hash = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      end
  end
end
