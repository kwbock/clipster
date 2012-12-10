require 'spec_helper'

describe Clipster::AboutController do
  render_views

  before(:each) { @routes = Clipster::Engine.routes }
  
  # Testing the index view.
  it "renders index template on index call" do
    get :index
    response.should render_template(:index)
  end
end
