require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/algeria/startseite/verein/3614",
"http://www.transfermarkt.co.uk/ivory-coast/startseite/verein/3591",
"http://www.transfermarkt.co.uk/ghana/startseite/verein/3441",
"http://www.transfermarkt.co.uk/tunisia/startseite/verein/3670",
"http://www.transfermarkt.co.uk/senegal/startseite/verein/3499",
"http://www.transfermarkt.co.uk/cape-verde/startseite/verein/4311",
"http://www.transfermarkt.co.uk/cameroon/startseite/verein/3434",
"http://www.transfermarkt.co.uk/congo/startseite/verein/3702",
"http://www.transfermarkt.co.uk/dr-congo/startseite/verein/3854",
"http://www.transfermarkt.co.uk/mali/startseite/verein/3674",
"http://www.transfermarkt.co.uk/gabon/startseite/verein/5704",
"http://www.transfermarkt.co.uk/equat-guinea/startseite/verein/13485",
"http://www.transfermarkt.co.uk/zambia/startseite/verein/3703",
"http://www.transfermarkt.co.uk/south-africa/startseite/verein/3806",
"http://www.transfermarkt.co.uk/uganda/startseite/verein/13497",
"http://www.transfermarkt.co.uk/egypt/startseite/verein/3672",
"http://www.transfermarkt.co.uk/nigeria/startseite/verein/3444",
"http://www.transfermarkt.co.uk/guinea/startseite/verein/3856",
"http://www.transfermarkt.co.uk/burkina-faso/startseite/verein/5872",
"http://www.transfermarkt.co.uk/togo/startseite/verein/3815",
"http://www.transfermarkt.co.uk/morocco/startseite/verein/3575",
"http://www.transfermarkt.co.uk/sudan/startseite/verein/13313",
"http://www.transfermarkt.co.uk/mauritania/startseite/verein/14238",
"http://www.transfermarkt.co.uk/rwanda/startseite/verein/3855",
"http://www.transfermarkt.co.uk/liberia/startseite/verein/9172",
"http://www.transfermarkt.co.uk/angola/startseite/verein/3585",
"http://www.transfermarkt.co.uk/benin/startseite/verein/3955",
"http://www.transfermarkt.co.uk/ethiopia/startseite/verein/13941",
"http://www.transfermarkt.co.uk/botswana/startseite/verein/15229",
"http://www.transfermarkt.co.uk/burundi/startseite/verein/13943",
"http://www.transfermarkt.co.uk/niger/startseite/verein/14163",
"http://www.transfermarkt.co.uk/namibia/startseite/verein/3573",
"http://www.transfermarkt.co.uk/libya/startseite/verein/6602",
"http://www.transfermarkt.co.uk/mozambique/startseite/verein/5129",
"http://www.transfermarkt.co.uk/madagascar/startseite/verein/14635",
"http://www.transfermarkt.co.uk/kenya/startseite/verein/8987",
"http://www.transfermarkt.co.uk/swaziland/startseite/verein/13675",
"http://www.transfermarkt.co.uk/tanzania/startseite/verein/14666",
"http://www.transfermarkt.co.uk/comoros/startseite/verein/16430"
]

national = [
"Algeria","Ivory Coast","Ghana","Tunisia","Senegal",
"Cape Verde","Cameroon","Congo","DR Congo","Mali",
"Gabon","Equatorial Guinea","Zambia","South Africa","Uganda",
"Egypt","Nigeria","Guinea","Burkina Faso","Togo",
"Morocco","Sudan","Mauritania","Rwanda","Liberia",
"Angola","Benin","Ethiopia","Botswana","Burundi",
"Niger","Namibia","Libya","Mozambique","Madagascar",
"Kenya","Swaziland","Tanzania","Comoros"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 8..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  team = Transfer.get_player_team(player_doc)
  position = Transfer.get_player_position(player_doc)
  age = Transfer.get_player_age(player_doc)
  height = Transfer.get_player_height(player_doc)
  name = Transfer.get_player_name(player_doc)
  team_url = Transfer.get_team_url(player_doc)
  team_doc = Transfer.get_team_doc(team_url)
  team_national = Transfer.get_team_national(team_doc)
  division = Transfer.get_team_division(team_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,team,team_national,division) values (?,?,?,?,?,?,?,?) on duplicate key update team=?,team_national=?,division=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],team[i],team_national[i],division[i],team[i],team_national[i],division[i]
  end
end

st.close()
connection.close()
