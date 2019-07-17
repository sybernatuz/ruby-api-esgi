class BaseCrawler
  include Nokogiri
  require 'open-uri'
  require 'json'

  def self.get_rs_json(url)
    doc = Nokogiri.HTML(open(url))
    json_data = doc.xpath("//script[@type='application/ld+json']")[0].text
    return JSON.parse(json_data)
  end
end

