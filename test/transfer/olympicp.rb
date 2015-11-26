require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/mexico-u23/leistungsdaten/verein/16418/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/sweden-u21/leistungsdaten/verein/8595/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/germany-u21/leistungsdaten/verein/3817/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/denmark-u21/leistungsdaten/verein/16783/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/fiji-u23/leistungsdaten/verein/35749/plus/0?reldata=%262015"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
