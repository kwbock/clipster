describe "expiring clips" do

  after do
    Timecop.return
  end

  it "creates a clip that expires in 1 hour" do
    #create the Clip
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
      select('An Hour', :from => 'clip_lifespan')
    end
    click_button 'Create Clip'

    # Verify clip creation
    page.should have_content('Expires: About 1 hour')
    page.should have_content('short example clip')

    # Move 30 minutes ahead
    Timecop.travel(30*60)
    visit(current_path)
    page.should have_content('Expires: 30 minutes')

    # Move past expire
    Timecop.travel(60*60 + 1)
    visit(current_path)
    page.should have_content('Sorry, This is an invalid clip or it has expired.')
  end

  it "creates a clip that expires in 1 day" do
    #create the Clip
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
      select('A Day', :from => 'clip_lifespan')
    end
    click_button 'Create Clip'

    # Verify clip creation
    page.should have_content('Expires: 1 day')
    page.should have_content('short example clip')

    # Move 12 hours ahead
    Timecop.travel(12*60*60)
    visit(current_path)
    page.should have_content('Expires: About 12 hours')

    # Move past expire
    Timecop.travel(24*60*60 + 1)
    visit(current_path)
    page.should have_content('Sorry, This is an invalid clip or it has expired.')
  end

  it "creates a clip that expires in 1 week" do
    #create the Clip
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
      select('A Week', :from => 'clip_lifespan')
    end
    click_button 'Create Clip'

    # Verify clip creation
    page.should have_content('Expires: 7 days')
    page.should have_content('short example clip')
    
    # Move past expire
    Timecop.travel(7*24*60*60 + 1)
    visit(current_path)
    page.should have_content('Sorry, This is an invalid clip or it has expired.')
  end

  it "creates a clip that expires in 1 year" do
    #create the Clip
    visit new_clip_path
    within("#new_clip") do
      fill_in 'clip_clip', :with => 'short example clip'
      select('A Year', :from => 'clip_lifespan')
    end
    click_button 'Create Clip'

    # Verify clip creation
    page.should have_content('Expires: About 1 year')
    page.should have_content('short example clip')

    # Move 364 days ahead
    Timecop.travel(364*24*60*60)
    visit(current_path)
    page.should have_content('Expires: 1 day')

    # Move past expire
    Timecop.travel(364*24*60*60 + 1)
    visit(current_path)
    page.should have_content('Sorry, This is an invalid clip or it has expired.')
  end

end