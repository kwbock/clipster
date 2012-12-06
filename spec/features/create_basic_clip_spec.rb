describe "creating clips" do

  it "creates a clip using the default values" do
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
    end
    click_button 'Create Clip'

    # Verify the defaults
    page.should have_content('Untitled')
    page.should have_content('A Text clip')
    page.should have_content('Expires: The end of time')
    page.should have_content('short example clip')
  end

  it "creates a clip with a unique title" do
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
      fill_in 'clip_title', :with => 'A Title'
    end
    click_button 'Create Clip'

    page.should have_content('A Title')
    page.should have_content('short example clip')
  end

  it "creates a ruby clip" do
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'puts "hello world!"'
      select('Ruby', :from => 'clip_language')
    end
    click_button 'Create Clip'

    page.should have_content('A Ruby clip')
    page.should have_content('puts "hello world!"')
  end

  it "creates an expiring clip" do
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'puts "hello world!"'
      select('An Hour', :from => 'clip_lifespan')
    end
    click_button 'Create Clip'

    page.should have_content('Expires: About 1 hour')
    page.should have_content('puts "hello world!"')
  end

  it "will not create an empty clip" do
    visit new_clip_path
    click_button 'Create Clip'

    page.should have_content('1 error prohibited this clip from being saved')
    page.should have_content('There were problems with the following fields:')
    page.should have_content('Clip is too short (minimum is 3 characters)')
  end

  it "will not create a clip without a title" do
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'puts "hello world!"'
      fill_in 'clip_title', :with => ''
    end
    click_button 'Create Clip'

    page.should have_content('1 error prohibited this clip from being saved')
    page.should have_content('There were problems with the following fields:')
    page.should have_content('Title is too short (minimum is 1 characters)')
  end
end