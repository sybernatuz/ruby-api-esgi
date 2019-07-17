class DefaultCrawler
  include Nokogiri
  require_relative '../../../../app/services/crawler/base_crawler'
  require 'open-uri'
  require 'json'

  def self.create_post_from_rs_json(url)
    json = BaseCrawler.get_rs_json(url)
    image = json.detect {|hash| !hash["image"].nil? }['image']['url']
    description = json.detect {|hash| !hash["description"].nil? }['description']
    title = json.detect {|hash| !hash["headline"].nil? }['headline']
    date = json.detect {|hash| !hash["datePublished"].nil? }['datePublished']
    category = URI(url).path.split('/')[1]
    return Post.create(title: title, picture: image, text: description, created_at: date, link: url, category: category)
  end
end



