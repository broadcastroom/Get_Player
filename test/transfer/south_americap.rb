require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/argentina/leistungsdaten/verein/3437",
"http://www.transfermarkt.co.uk/brazil/leistungsdaten/verein/3439",
"http://www.transfermarkt.co.uk/chile/leistungsdaten/verein/3700",
"http://www.transfermarkt.co.uk/uruguay/leistungsdaten/verein/3449",
"http://www.transfermarkt.co.uk/ecuador/leistungsdaten/verein/5750",
"http://www.transfermarkt.co.uk/peru/leistungsdaten/verein/3584",
"http://www.transfermarkt.co.uk/paraguay/leistungsdaten/verein/3581",
"http://www.transfermarkt.co.uk/bolivia/leistungsdaten/verein/5233",
"http://www.transfermarkt.co.uk/venezuela/leistungsdaten/verein/3504",
"http://www.transfermarkt.co.uk/colombia/leistungsdaten/verein/3816"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
