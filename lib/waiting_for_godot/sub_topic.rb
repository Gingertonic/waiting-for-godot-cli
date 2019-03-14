class WaitingForGodot::SubTopic
  attr_accessor :name, :url, :content

  def initialize(name, url)
    @name = name
    @url = url
    @content = []
  end

  def get_details
    WaitingForGodot::Scraper.scrape_details(self)
  end

end
