require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/trinidad/leistungsdaten/verein/7149/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/panama/leistungsdaten/verein/3577/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/haiti/leistungsdaten/verein/14161/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/guatemala/leistungsdaten/verein/13342/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/el-salvador/leistungsdaten/verein/13951/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/st-vincent/leistungsdaten/verein/17762/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/usatm/leistungsdaten/verein/3505/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/costa-rica/leistungsdaten/verein/8497/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/honduras/leistungsdaten/verein/3590/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/jamaika/leistungsdaten/verein/3671/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/canada/leistungsdaten/verein/3510/plus/0?reldata=%262016"
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
