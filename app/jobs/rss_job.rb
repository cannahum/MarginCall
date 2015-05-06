require 'open-uri'
require 'csv'
require 'rss'

class RssJob 

  def self.getrss(ticker)
  	s = Stock.find_by(:ticker => ticker)
  	if s.collection == false
  	  url = "http://finance.yahoo.com/rss/headline?s=#{ticker}"
  	  rss = RSS::Parser.parse(open(url))
  	  return rss
  	else	
  	  return nil
  	end
  end
end


