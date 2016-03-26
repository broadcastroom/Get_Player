require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/japan/leistungsdaten/verein/3435/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/japan-u23/startseite/verein/28642"
]

national = [
"Japan U23","Japan U23","Japan","Japan U23"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 0..(url.size-1)

  k=0
  p national[j]
  p j*100/national.length
  test_doc = Transfer.crawl(url[j])
  minutes = Transfer.get_player_minutes(test_doc)
  player_url = Transfer.get_player_url(test_doc)

  player_doc = Transfer.get_player_doc(player_url)
  team = Transfer.get_player_team(player_doc)
  position = Transfer.get_player_position(player_doc)
  age = Transfer.get_player_age(player_doc)
  height = Transfer.get_player_height(player_doc)
  p name = Transfer.get_player_name(player_doc)
  team_url = Transfer.get_team_url(player_doc)
  team_doc = Transfer.get_team_doc(team_url)
  team_national = Transfer.get_team_national(team_doc)
  division = Transfer.get_team_division(team_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"Japan",team[i],team_national[i],division[i],minutes[i],"Japan",team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
