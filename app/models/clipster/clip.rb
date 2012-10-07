module Clipster
  class Clip < ActiveRecord::Base
    before_create :init_id
    self.primary_key = :url_hash
    attr_accessible :clip, :language, :title, :private
    
    validates :clip, :length => {:minimum   => 3}
    
    private
      def init_id
        self.url_hash = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      end
  end
end
