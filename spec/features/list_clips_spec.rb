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

  it "does not have pagination for less than 26 public clips" do
    # Should already have 6 public clips, create 19 more
    FactoryGirl.create_list(:clip, 19)

    visit clips_clips_path
    page.should_not have_link("Next")
    page.should_not have_link("Last")
  end

  it "has pagination for 26 or more public clips" do
    # Should already have 6 public clips, create 20 more
    FactoryGirl.create_list(:clip, 20)

    visit clips_clips_path
    page.should have_link("2")
    page.should have_link("Next")
    page.should have_link("Last")
  end

  it "uses pagination" do
    FactoryGirl.create_list(:clip, 30)

    visit clips_clips_path
    click_link "Next"
    page.should have_link("Prev")
    page.should have_content("Title Language")
    page.should have_content("Untitled Text")
  end

  it "uses pagination with a language filter" do
    FactoryGirl.create_list(:clip, 60)

    visit clips_clips_path(:lang => "text")
    click_link "Next"
    page.should have_link("Prev")
    page.should_not have_content("Ruby")
    current_url.should have_content("lang=text")
  end
end