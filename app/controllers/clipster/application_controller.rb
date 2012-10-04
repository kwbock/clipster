module Clipster
  class ApplicationController < ActionController::Base
    def index
      render :text => "Welcome to Clipster"
    end 
  end
end
