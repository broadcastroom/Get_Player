require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/new-zealand/leistungsdaten/verein/9171/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/new-zealand/leistungsdaten/verein/9171/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/fidschi/startseite/verein/13955/saison_id/2015",
"http://www.transfermarkt.co.uk/samoa/leistungsdaten/verein/15235/plus/0?reldata=WMQ5%262015"
]

for j in 0..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
