module Clipster
  class ApplicationController < ActionController::Base
    def index
      render :text => "Welcome 2 Clipster"
    end 
  end
end
