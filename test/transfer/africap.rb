require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/uganda/leistungsdaten/verein/13497/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/egypt/leistungsdaten/verein/3672/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/nigeria/leistungsdaten/verein/3444/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/morocco/leistungsdaten/verein/3575/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/libya/leistungsdaten/verein/6602/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/zambia/leistungsdaten/verein/3703/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/algeria/leistungsdaten/verein/3614/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/ivory-coast/leistungsdaten/verein/3591/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/ghana/leistungsdaten/verein/3441/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/tunisia/leistungsdaten/verein/3670/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/senegal/leistungsdaten/verein/3499/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/cape-verde/leistungsdaten/verein/4311/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/cameroon/leistungsdaten/verein/3434/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/congo/leistungsdaten/verein/3702/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/dr-congo/leistungsdaten/verein/3854/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/mali/leistungsdaten/verein/3674/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/gabon/leistungsdaten/verein/5704/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/south-africa/leistungsdaten/verein/3806/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/guinea/leistungsdaten/verein/3856/plus/0?reldata=%262016",
"http://www.transfermarkt.co.uk/burkina-faso/leistungsdaten/verein/5872/plus/0?reldata=%262016",
]

for j in 0..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end
