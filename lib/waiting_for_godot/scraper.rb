class WaitingForGodot::Scraper
  def self.scrape_topics
    doc = Nokogiri::HTML(open("https://www.cliffsnotes.com/literature/w/waiting-for-godot"))
    doc.css("ul.toc-list > li").each do |li|
      name = li.css("a")[0].text.strip
      url = li.css("a")[0].attr("href").strip
      nested = !!li.css("a")[1] ? true : false
      WaitingForGodot::Topic.new(name, url, nested)
    end
  end

  def self.scrape_sub_topics(topic)
    sub_topics = []
    doc = Nokogiri::HTML(open("https://www.cliffsnotes.com/literature/w/waiting-for-godot"))
    doc.css("ul.toc-list > li").each do |li|
      if li.css("a")[0].text.strip === topic.name
        # binding.pry
        li.css("a").each do |st|
          name = st.text.strip
          url = st.attr("href")
          sub_topics << WaitingForGodot::SubTopic.new(name, url)
        end
        sub_topics.shift
        topic.sub_topics = sub_topics
      end
    end
  end

  def self.scrape_details(topic)
    doc = Nokogiri::HTML(open("https://www.cliffsnotes.com#{topic.url}"))
    doc.css("article.copy p.litNoteText").each do |paragraph|
      topic.content << paragraph.text.strip
    end
  end
end
