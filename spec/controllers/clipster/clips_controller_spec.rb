require 'spec_helper'

describe Clipster::ClipsController do
  render_views

  fixtures :clipster_clips

  before(:each) { @routes = Clipster::Engine.routes }

  # Testing the new view.
  it "renders new template on new call" do
    get :new
    response.should render_template(:new)
  end

  # Testing the show/:id view
  it "renders show template on show call" do
    clip = FactoryGirl.create(:clip, :title=>"Foobar", :language=>"ruby")
    get :show, :id => clip.id

    # test that the correct template was rendered
    response.should render_template(:show)
    response.body.should =~ /Foobar/
    response.body.should =~ /Ruby/
  end

  # Testing list/ view
  it "renders list template on clips call" do
    get :clips
    response.should render_template(:clips)
  end

  # Testing list/:lang view
  it "renders list template on clips call for ruby" do
    get :clips, :lang => :ruby
    response.should render_template(:clips)
  end
end
