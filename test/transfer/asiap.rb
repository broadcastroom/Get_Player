require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/north-korea/leistungsdaten/verein/15457/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/south-korea/leistungsdaten/verein/3589/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/china/leistungsdaten/verein/5598/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/iraq/leistungsdaten/verein/3560/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/united-arab-emirates/leistungsdaten/verein/5147/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/saudi-arabia/leistungsdaten/verein/3807/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/oman/leistungsdaten/verein/14165/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/qatar/leistungsdaten/verein/14162/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/jordan/leistungsdaten/verein/15737/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/kuwait/leistungsdaten/verein/3432/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/syria/leistungsdaten/verein/13674/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/lebanon/leistungsdaten/verein/3586/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/thailand/leistungsdaten/verein/5676/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/iran/leistungsdaten/verein/3582/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/hong-kong/leistungsdaten/verein/15977/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/philippinen/leistungsdaten/verein/15234/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/australia/leistungsdaten/verein/3433/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/uzbekistan/leistungsdaten/verein/3563/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/palestine/leistungsdaten/verein/17758/plus/0?reldata=WMQ1%262014"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
