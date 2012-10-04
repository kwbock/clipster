module Clipster
  class Clip < ActiveRecord::Base
    attr_accessible :clip, :id, :language
  end
end
