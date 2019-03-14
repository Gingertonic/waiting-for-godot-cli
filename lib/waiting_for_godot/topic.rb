
class WaitingForGodot::Topic
  @@all = []

  attr_accessor :id, :name, :url, :nested, :sub_topics, :content

 def initialize(name, url, nested)
   @name = name
   @url = url
   @nested = nested
   @id = @@all.count + 1
   @content = []
   save
 end

 def save
   @@all << self
 end

 def self.all
   @@all.empty? ? WaitingForGodot::Scraper.scrape_topics : nil
   @@all
 end

 def self.find(idx)
   all.find{|t| t.id === idx.to_i}
 end

 def get_sub_topics
   WaitingForGodot::Scraper.scrape_sub_topics(self)
 end

 def get_details
   WaitingForGodot::Scraper.scrape_details(self)
 end

end
