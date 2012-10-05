require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      @clips = Clip.all
      
      @languages = []
      #CodeRay::Scanners.all_plugins.each do |language|
      #  @languages << language.title.to_s
      #end
    end
  end
end
