require 'spec_helper'

describe Clipster::ClipsController do
  render_views

  before(:each) { @routes = Clipster::Engine.routes }

  it "should render index template on index call" do
    get :index

    response.should render_template("create")
  end
end
