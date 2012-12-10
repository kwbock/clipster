describe "search clips" do

  it "finds a clip using the title" do
    clip = FactoryGirl.create(:clip, :title=>"h8sdf8UniqueTitle234")

    visit new_clip_path
    fill_in "search_term", :with => clip.title
    page.find("#search_button").click

    page.should have_content(clip.title)
  end

  it "finds a clip using the language" do
    clip = FactoryGirl.create(:clip, :language=>"clojure")

    visit new_clip_path
    fill_in "search_term", :with => clip.language
    page.find("#search_button").click

    page.should have_content(clip.language)
  end

  it "finds a clip using the content" do
    clip = FactoryGirl.create(:clip, :title=>"234234235", :clip=>"h8sdf8UniqueContent234")

    visit new_clip_path
    fill_in "search_term", :with => clip.clip
    page.find("#search_button").click

    page.should have_content(clip.title)
  end

  it "appends a wildcard" do
    clip = FactoryGirl.create(:clip, :title=>"asdffUniqueTitle23423")

    visit new_clip_path
    fill_in "search_term", :with => "asdffUnique"
    page.find("#search_button").click

    page.should have_content(clip.title)
  end

  it "uses * as wildcard" do
    clip = FactoryGirl.create(:clip, :title=>"34534UniqueTitle67867")

    visit new_clip_path
    fill_in "search_term", :with => "34534Unique*67867"
    page.find("#search_button").click

    page.should have_content(clip.title)
  end

    it "uses % as wildcard" do
    clip = FactoryGirl.create(:clip, :title=>"2342342UniqueTitle745745")

    visit new_clip_path
    fill_in "search_term", :with => "2342342Unique%745745"
    page.find("#search_button").click

    page.should have_content(clip.title)
  end
end