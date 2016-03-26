require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/north-korea/leistungsdaten/verein/15457/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/south-korea/leistungsdaten/verein/3589/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/china/leistungsdaten/verein/5598/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/iraq/leistungsdaten/verein/3560/plus/0?reldata=WMQ1%262014",
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
"http://www.transfermarkt.co.uk/palestine/leistungsdaten/verein/17758/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/vietnam/leistungsdaten/verein/8778/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/turkmenistan/leistungsdaten/verein/14248/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/chinese-taipei-taiwan-/leistungsdaten/verein/15363/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/bahrain/leistungsdaten/verein/7214/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/united-arab-emirates/leistungsdaten/verein/5147/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/indonesien/startseite/verein/13958/saison_id/2014",
"http://www.transfermarkt.co.uk/guam/leistungsdaten/verein/17753/plus/0?reldata=WMQ1%262014"
]

for j in 24..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
