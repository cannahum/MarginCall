require 'open-uri'
require 'csv'
require 'rss'

class RssJob 

  def self.getrss(ticker)
  	s = Stock.find_by(:ticker => ticker)
  	if s!=nil && s.collection == false
  	  url = "http://finance.yahoo.com/rss/headline?s=#{ticker}"
  	  rss = RSS::Parser.parse(open(url))
  	  return rss
  	else
    url = "http://finance.yahoo.com/rss/headline?s=INDU"
    rss = RSS::Parser.parse(open(url))
  	  return rss
  	end
  end
end


