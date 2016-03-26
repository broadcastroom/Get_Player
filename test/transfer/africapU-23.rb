require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/sudafrika-u23/leistungsdaten/verein/28649",
"http://www.transfermarkt.co.uk/senegal-u23/leistungsdaten/verein/34870",
"http://www.transfermarkt.co.uk/algerien-u23/leistungsdaten/verein/34867",
"http://www.transfermarkt.co.uk/nigeria-u23/leistungsdaten/verein/31096"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
