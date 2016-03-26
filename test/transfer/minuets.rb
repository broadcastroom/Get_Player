require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/poland/leistungsdaten/verein/3442/plus/0?reldata=EMQ%262014"
]

national = [
"Algeria"
]



  test_doc = Transfer.crawl(url[0])
p Transfer.get_player_url(test_doc)
p Transfer.get_player_minutes(test_doc)


