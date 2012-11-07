require 'spec_helper'

describe Clipster::ClipsController do
  render_views

  fixtures :clipster_clips

  before(:each) { @routes = Clipster::Engine.routes }

  # Testing the index view.
  # Change this view if we create an index template
  it "should render index template on index call" do
    get :index

    response.should render_template(:create)
  end

  # Testing the show/:id view
  it "should render show template on show call" do
    get :show, :id => :abc

    # test that the correct template was rendered
    response.should render_template(:show)

    # check that all fields from fixture were rendered correctly
    response.body.should =~ /Foobar/
    #response.body.should =~ /puts :foobar/
    response.body.should =~ /Ruby/
  end

  # Testing list/ view
  it "should render list template on list call" do
    get :list

    response.should render_template(:list)
  end

  # Testing list/:lang view
  it "should render list template on list call for ruby" do
    get :list, :lang => :ruby

    response.should render_template(:list)
  end
end
