require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
  "http://www.transfermarkt.co.uk/sweden-u21/leistungsdaten/verein/8595/plus/0?reldata=U215%262014",
  "http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U215%262014",
  "http://www.transfermarkt.co.uk/germany-u21/leistungsdaten/verein/3817/plus/0?reldata=U215%262014",
  "http://www.transfermarkt.co.uk/denmark-u21/leistungsdaten/verein/16783/plus/0?reldata=U215%262014",
  "http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U21Q%262015",
  "http://www.transfermarkt.co.uk/fiji-u23/leistungsdaten/verein/35749/plus/0?reldata=%262015",
  "http://www.transfermarkt.co.uk/brazil-u23/leistungsdaten/verein/37018/plus/0?reldata=%262015",
  "http://www.transfermarkt.co.uk/sudkorea-u23/startseite/verein/34950/saison_id/2015",
  "http://www.transfermarkt.co.uk/irak-u23/startseite/verein/40739/saison_id/2015",
  "http://www.transfermarkt.co.uk/iraq-u20/startseite/verein/39540",
  "http://www.transfermarkt.co.uk/sudafrika-u23/leistungsdaten/verein/28649",
  "http://www.transfermarkt.co.uk/algerien-u23/leistungsdaten/verein/34867",
  "http://www.transfermarkt.co.uk/nigeria-u23/leistungsdaten/verein/31096",
  "http://www.transfermarkt.co.uk/honduras-u23/startseite/verein/28376",
  "http://www.transfermarkt.co.uk/mexico-u23/startseite/verein/16418?saison_id=2015",
  "http://www.transfermarkt.co.uk/united-states-u23/startseite/verein/35707",
  "http://www.transfermarkt.co.uk/mexico-u23/startseite/verein/16418"
]

for j in 16..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
