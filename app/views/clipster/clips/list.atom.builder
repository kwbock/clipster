atom_feed do |feed|
  feed.title("Clipster - Recent")
  feed.updated(@updated_at) unless @updated_at.nil?

  @clips.each do |clip|
    feed.entry(clip) do |entry|
      if clip.expires.nil?
        entry.title("#{clip.title}. A #{clip.language} clip that never expires.")
      else
        entry.title("#{clip.title}. A #{clip.language} clip that expires on #{clip.expires}.")
      end
      entry.content(clip.div.html_safe, :type => 'html')
      
      #TODO set author once user integration is compleate
      #entry.author do |author|
      #  author.name("DHH")
      #end
    end
  end
end