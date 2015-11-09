require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/argentina/leistungsdaten/verein/3437/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/brazil/leistungsdaten/verein/3439",
"http://www.transfermarkt.co.uk/chile/leistungsdaten/verein/3700",
"http://www.transfermarkt.co.uk/uruguay/leistungsdaten/verein/3449",
"http://www.transfermarkt.co.uk/ecuador/leistungsdaten/verein/5750",
"http://www.transfermarkt.co.uk/peru/leistungsdaten/verein/3584",
"http://www.transfermarkt.co.uk/paraguay/leistungsdaten/verein/3581",
"http://www.transfermarkt.co.uk/bolivia/leistungsdaten/verein/5233",
"http://www.transfermarkt.co.uk/venezuela/leistungsdaten/verein/3504",
"http://www.transfermarkt.co.uk/colombia/leistungsdaten/verein/3816/plus/0?reldata=CA15%262014"
]

national = [
"Argentina","Brazil","Chile","Uruguay","Ecuador",
"Peru","Paraguay","Bolivia","Venezuela","Colombia"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 0..(url.size-1)
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

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"South America",team[i],team_national[i],division[i],minutes[i],"South America",team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
