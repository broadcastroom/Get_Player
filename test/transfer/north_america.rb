require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
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
"http://www.transfermarkt.co.uk/costa-rica/leistungsdaten/verein/8497/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/honduras/leistungsdaten/verein/3590/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/jamaika/leistungsdaten/verein/3671/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/canada/leistungsdaten/verein/3510/plus/0?reldata=WMQ3%262016"
]

national = [
"Trinidad and Tobago","Panama","Haiti","Guatemala","El Salvador",
"St.Vincent","Mexico","USA","Costa Rica","Honduras",
"Jamaica","Canada"
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

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"North America",team[i],team_national[i],division[i],minutes[i],"North America",team[i],team_national[i],division[i]
  end
end

st.close()
connection.close()
