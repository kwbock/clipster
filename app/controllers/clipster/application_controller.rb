module Clipster
  class ApplicationController < ActionController::Base
    def index
      render :text => "hello clipster"
    end
  end
end
