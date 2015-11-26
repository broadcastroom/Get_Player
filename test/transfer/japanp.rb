require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/japan/leistungsdaten/verein/3435/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262015"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
