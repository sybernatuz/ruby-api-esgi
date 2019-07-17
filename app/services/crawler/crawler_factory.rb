class CrawlerFactory
  require 'uri'
  require_relative '../../../app/services/crawler/strategies/lemonde_crawler'
  require_relative '../../../app/services/crawler/strategies/default_crawler'

  def self.crawl(url)
    case get_domain(url)
    when "www.lemonde.fr"
      return LemondeCrawler.create_post_from_rs_json(url)
    else
      begin
        return LemondeCrawler.create_post_from_rs_json(url)
      rescue
        return DefaultCrawler.create_post_from_rs_json(url)
      end
    end
  end

  private

  def self.get_domain(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host
  end
end
