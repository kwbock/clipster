describe "list clips" do

  before(:all) do
    # Setup some default clips to be used in the list
    FactoryGirl.create(:clip, :title=>"Ruby Clip 1", :language=>"ruby")
    FactoryGirl.create(:clip, :title=>"Ruby Clip 2", :language=>"ruby")
    FactoryGirl.create(:clip, :title=>"Text Clip")
    FactoryGirl.create(:clip, :title=>"Java Clip", :language=>"java")
    FactoryGirl.create(:clip, :title=>"HTML Clip", :language=>"html")
    FactoryGirl.create(:clip, :title=>"Public PHP Clip", :language=>"php")
    
    # Private Clips
    FactoryGirl.create(:clip, :private, :title=>"Private PHP Clip", :language=>"php")
    
    # Expired
    FactoryGirl.create(:clip, :expired, :title=>"Expired Ruby Clip", :language=>"ruby")
  end
  
  it "validates private clips are not in the public list" do
    visit clips_clips_path
    page.should have_content("Ruby Clip 1 Ruby")
    page.should have_content("Ruby Clip 2 Ruby")
    page.should have_content("Text Clip Text")
    page.should have_content("Java Clip Java")
    page.should have_content("Public PHP Clip Php")
    page.should_not have_content("Private PHP Clip Php")
  end

  it "validates language filter" do
    visit clips_clips_path(:lang => "ruby")
    page.should have_content("Ruby Clip 1 Ruby")
    page.should have_content("Ruby Clip 2 Ruby")
    page.should_not have_content("Text Clip Text")
    page.should_not have_content("Java Clip Java")
    page.should_not have_content("Public PHP Clip Php")
  end
  
  it "validates language counts" do
    visit clips_clips_path
    page.should have_content("ruby (2)")
    page.should have_content("text (1)")
    page.should have_content("java (1)")
    page.should have_content("html (1)")
    page.should have_content("ruby (2)")
  end
end