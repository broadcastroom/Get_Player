require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
  "http://www.transfermarkt.co.uk/uganda/leistungsdaten/verein/13497/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/egypt/leistungsdaten/verein/3672/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/nigeria/leistungsdaten/verein/3444/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/libya/leistungsdaten/verein/6602/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/zambia/leistungsdaten/verein/3703/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/algeria/leistungsdaten/verein/3614/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/ivory-coast/leistungsdaten/verein/3591/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/tunisia/leistungsdaten/verein/3670/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/senegal/leistungsdaten/verein/3499/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/cameroon/leistungsdaten/verein/3434/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/congo/leistungsdaten/verein/3702/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/gabon/leistungsdaten/verein/5704/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/burkina-faso/leistungsdaten/verein/5872/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/tanzania/leistungsdaten/verein/14666/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/mozambique/leistungsdaten/verein/5129/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/the-gambia/leistungsdaten/verein/6186/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/south-africa/leistungsdaten/verein/3806/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/morocco/leistungsdaten/verein/3575/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/guinea/leistungsdaten/verein/3856/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/ghana/leistungsdaten/verein/3441/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/guinea-bissau/leistungsdaten/verein/3701/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/mali/leistungsdaten/verein/3674/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/cape-verde/leistungsdaten/verein/4311/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/dr-congo/leistungsdaten/verein/3854/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/sierra-leone/leistungsdaten/verein/6187/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/angola/leistungsdaten/verein/3585/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/liberia/leistungsdaten/verein/9172/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/curacao/leistungsdaten/verein/32364/plus/0?reldata=WMQ3%262016",
  "http://www.transfermarkt.co.uk/ethiopia/leistungsdaten/verein/13941/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/togo/leistungsdaten/verein/3815/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/benin/leistungsdaten/verein/3955/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/chad/leistungsdaten/verein/13978/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/niger/leistungsdaten/verein/14163/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/malawi/leistungsdaten/verein/8988/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/zimbabwe/leistungsdaten/verein/3583/plus/0?reldata=AFCQ%262014",
  "http://www.transfermarkt.co.uk/burundi/leistungsdaten/verein/13943/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/mauritania/leistungsdaten/verein/14238/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/central-african-republic/leistungsdaten/verein/12933/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/comoros/leistungsdaten/verein/16430/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/sao-tome-and-principe/leistungsdaten/verein/15236/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/kenya/leistungsdaten/verein/8987/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/madagascar/leistungsdaten/verein/14635/plus/0?reldata=WMQ2%262016",
  "http://www.transfermarkt.co.uk/mauritius/leistungsdaten/verein/14239/plus/0?reldata=WMQ2%262016"
]

for j in 0..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
