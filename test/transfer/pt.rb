require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/hungary/leistungsdaten/verein/3468/plus/0?reldata=EMQ%262014"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
