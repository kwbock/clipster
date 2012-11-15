require 'spec_helper'

describe Clipster::UsersController do

  before(:each) { @routes = Clipster::Engine.routes }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => 1

      response.should be_success
    end
  end

end
