require 'open-uri'
require 'csv'
require 'rss'

class RssJob 

  def self.getrss(ticker)
  	url = "http://finance.yahoo.com/rss/headline?s=#{ticker}"
  	#rss = RSS::Parser.parse(open(url))
  	#return rss
  	
  end
end


