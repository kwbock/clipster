atom_feed do |feed|
  feed.title("Clipster - Recent")
  feed.updated(@updated_at) unless @updated_at.nil?

  @clips.each do |clip|
    feed.entry(clip) do |entry|
      entry.title(clip.title)
      entry.subtitle("A #{clip.language} clip that expires on #{clip.expires}")
      entry.updated(clip.updated_at)
      entry.content(clip.div.html_safe, :type => 'html')
      
      #TODO set author once user integration is compleate
      #entry.author do |author|
      #  author.name("DHH")
      #end
    end
  end
end