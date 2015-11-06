require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/argentina-u20/leistungsdaten/verein/11940",
"http://www.transfermarkt.co.uk/honduras-u23/leistungsdaten/verein/28376",
"http://www.transfermarkt.co.uk/mexico-u23/leistungsdaten/verein/16418/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/sweden-u21/leistungsdaten/verein/8595/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/germany-u21/leistungsdaten/verein/3817/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/denmark-u21/leistungsdaten/verein/16783/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/fiji-u23/leistungsdaten/verein/35749/plus/0?reldata=OFC5%262015"
]

national = [
"Argentina U20","Honduras U23","Mexico U23","Japan U23","Sweden U23",
"Portugal U23","Germany U23","Denmark U23","Fiji U23"
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
  minutes = Transfer.get_player_minutes(test_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?) on duplicate key update team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],team[i],team_national[i],division[i],minutes[i],team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
