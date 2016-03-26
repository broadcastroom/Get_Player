require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/hungary/leistungsdaten/verein/3468/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/northern-ireland/leistungsdaten/verein/5674/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/germany/leistungsdaten/verein/3262/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/belgium/leistungsdaten/verein/3382/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/portugal/leistungsdaten/verein/3300/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/spain/leistungsdaten/verein/3375/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/wales/leistungsdaten/verein/3864/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/england/leistungsdaten/verein/3299/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/austria/leistungsdaten/verein/3383/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/switzerland/leistungsdaten/verein/3384/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/netherlands/leistungsdaten/verein/3379/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/czech-republic/leistungsdaten/verein/3445/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/croatia/leistungsdaten/verein/3556/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/italy/leistungsdaten/verein/3376/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/slovakia/leistungsdaten/verein/3503/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/ukraine/leistungsdaten/verein/3699/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/russia/leistungsdaten/verein/3448/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/denmark/leistungsdaten/verein/3436/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/bosnia-h-/leistungsdaten/verein/3446/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/albania/leistungsdaten/verein/3561/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/norway/leistungsdaten/verein/3440/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/turkey/leistungsdaten/verein/3381/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/scotland/leistungsdaten/verein/3380/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/poland/leistungsdaten/verein/3442/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/sweden/leistungsdaten/verein/3557/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/slovenia/leistungsdaten/verein/3588/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/israel/leistungsdaten/verein/5547/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/ireland/leistungsdaten/verein/3509/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/serbia/leistungsdaten/verein/3438/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/finland/leistungsdaten/verein/3443/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/bulgaria/leistungsdaten/verein/3394/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/estonia/leistungsdaten/verein/6133/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/armenia/leistungsdaten/verein/6219/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/belarus/leistungsdaten/verein/3450/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/latvia/leistungsdaten/verein/3555/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/azerbaijan/leistungsdaten/verein/8605/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/cyprus/leistungsdaten/verein/3668/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/lithuania/leistungsdaten/verein/3851/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/macedonia/leistungsdaten/verein/5148/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/moldova/leistungsdaten/verein/6090/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/kazakhstan/leistungsdaten/verein/9110/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/iceland/leistungsdaten/verein/3574/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/luxembourg/leistungsdaten/verein/3580/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/montenegro/leistungsdaten/verein/11953/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/liechtenstein/leistungsdaten/verein/5673/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/greece/leistungsdaten/verein/3378/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/georgia/leistungsdaten/verein/3669/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/romania/leistungsdaten/verein/3447/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/france/leistungsdaten/verein/3377/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/france/leistungsdaten/verein/3377/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/israel/leistungsdaten/verein/5547/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/israel/leistungsdaten/verein/5547/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/faroe-islands/leistungsdaten/verein/9173/plus/0?reldata=EMQ%262014"
]

for j in 0..(url.size-1)
  p url[j]
  p j*100/url.length
  test_doc = Transfer.crawl(url[j])
  Transfer.get_player_picture(test_doc)
end
