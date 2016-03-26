require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/australien-u23/leistungsdaten/verein/32270"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
