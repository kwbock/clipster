require 'spec_helper'

describe "api" do

  context "using xml" do
    it "creates a minimal clip using xml" do
      xml = '<?xml version="1.0" encoding="UTF-8"?>
             <clip>
               <clip>test XML API clip creation</clip>
             </clip>'
      
      post create_clips_path("xml"), xml, {
        "CONTENT_TYPE" => 'application/xml',
        "HTTP_ACCEPT" => 'application/xml'
      }
      response.response_code.should eq 201
    end
  
    it "fails when it doesn't pass validation" do
      xml = '<?xml version="1.0" encoding="UTF-8"?>
             <clip>
               <clip>te</clip>
             </clip>'
      
      post create_clips_path("xml"), xml, {
        "CONTENT_TYPE" => 'application/xml',
        "HTTP_ACCEPT" => 'application/xml'
      }
      response.response_code.should eq 422
    end
    
    it "only allows valid languages" do
      xml = '<?xml version="1.0" encoding="UTF-8"?>
             <clip>
               <clip>puts "hello world!"</clip>
               <language>fake_language</language>
             </clip>'
      
      post create_clips_path("xml"), xml, {
        "CONTENT_TYPE" => 'application/xml',
        "HTTP_ACCEPT" => 'application/xml'
      }
      response.body.should =~ /Language fake_language is not supported/
      response.response_code.should eq 422
    end
    
    it "only allows valid lifespans" do
      xml = '<?xml version="1.0" encoding="UTF-8"?>
             <clip>
               <clip>puts "hello world!"</clip>
               <lifespan>fake_time</lifespan>
             </clip>'
      
      post create_clips_path("xml"), xml, {
        "CONTENT_TYPE" => 'application/xml',
        "HTTP_ACCEPT" => 'application/xml'
      }
      response.body.should =~ /Lifespan fake_time is not supported/
      response.response_code.should eq 422
    end
    
    it "protects the user attribute" do
      xml = '<?xml version="1.0" encoding="UTF-8"?>
             <clip>
               <clip>puts "hello world!"</clip>
               <user>452345345</user>
             </clip>'
      
      post create_clips_path("xml"), xml, {
        "CONTENT_TYPE" => 'application/xml',
        "HTTP_ACCEPT" => 'application/xml'
      }
      response.body.should =~ /Security - Can't mass-assign protected attributes: user/
      response.response_code.should eq 422
    end
    
    it "can view an existing clip" do
      clip = FactoryGirl.create(:clip, :title=>"123unique_title123")
      get clip_path(clip, "xml")
      response.body.should =~ /123unique_title123/
      response.response_code.should eq 200
    end
    
    it "can't view an expired clips" do
      clip = FactoryGirl.create(:clip, :expired)
      get clip_path(clip, "xml")
      response.response_code.should eq 404
    end
    
    it "can search clips" do
      clip = FactoryGirl.create(:clip, :clip=>"55specific_clip55", :title=>"88unique_title88")
      get search_clips_path(:search_term=>"55specific_clip55", :format=>"xml")
      response.response_code.should eq 200
      response.body.should =~ /88unique_title88/
    end
  end
  
  context "using json" do
    it "creates a minimal clip" do
      json = '{"clip":{"clip":"hello world!"}}'
      
      post create_clips_path("json"), json, {
        "CONTENT_TYPE" => 'application/json',
        "HTTP_ACCEPT" => 'application/json'
      }
      response.response_code.should eq 201
    end
    
    it "can view clip" do
      clip = FactoryGirl.create(:clip, :title=>"45unique_title145")
      get clip_path(clip, "json")
      response.body.should =~ /45unique_title145/
      response.response_code.should eq 200
    end
  end
end