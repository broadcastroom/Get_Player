require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/japan/leistungsdaten/verein/3435/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/japan-u23/startseite/verein/28642"
]

for j in 3..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
