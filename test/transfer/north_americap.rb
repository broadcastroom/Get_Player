require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/trinidad/leistungsdaten/verein/7149/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/panama/leistungsdaten/verein/3577/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/haiti/leistungsdaten/verein/14161/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/guatemala/leistungsdaten/verein/13342/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/el-salvador/leistungsdaten/verein/13951/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/st-vincent/leistungsdaten/verein/17762/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/usatm/leistungsdaten/verein/3505/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/united-states/leistungsdaten/verein/3505/plus/0?reldata=CCPL%262015",
"http://www.transfermarkt.co.uk/united-states/leistungsdaten/verein/3505/plus/0?reldata=GC15%262014",
"http://www.transfermarkt.co.uk/costa-rica/leistungsdaten/verein/8497/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/honduras/leistungsdaten/verein/3590/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/jamaika/leistungsdaten/verein/3671/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/canada/leistungsdaten/verein/3510/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/antigua-and-barbuda/leistungsdaten/verein/16028/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/saint-kitts-and-nevis/leistungsdaten/verein/17760/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/aruba/leistungsdaten/verein/17749/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/guyana/leistungsdaten/verein/15736/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/martinique/leistungsdaten/verein/19758/plus/0?reldata=CC14%262014",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303/plus/0?reldata=GC15%262014"
]

for j in 19..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
