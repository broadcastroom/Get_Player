require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/macedonia-u21/leistungsdaten/verein/16844/plus/0?reldata=U21Q%262015"

]

national = [
"Macedonia U21"
]

  test_doc = Transfer.crawl(url[0])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
p team = Transfer.get_player_team(player_doc)
