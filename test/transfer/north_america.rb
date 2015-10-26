require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/jamaica/startseite/verein/3671",
"http://www.transfermarkt.co.uk/trinidad/startseite/verein/7149",
"http://www.transfermarkt.co.uk/panama/startseite/verein/3577",
"http://www.transfermarkt.co.uk/haiti/startseite/verein/14161",
"http://www.transfermarkt.co.uk/guatemala/startseite/verein/13342",
"http://www.transfermarkt.co.uk/honduras/startseite/verein/3590",
"http://www.transfermarkt.co.uk/el-salvador/startseite/verein/13951",
"http://www.transfermarkt.co.uk/st-vincent/startseite/verein/17762",
"http://www.transfermarkt.co.uk/mexico/startseite/verein/6303",
"http://www.transfermarkt.co.uk/usatm/startseite/verein/3505",
"http://www.transfermarkt.co.uk/costa-rica/startseite/verein/8497"
]

national = [
"Jamaica","Trinidad and Tobago","Panama","Haiti","Guatemala",
"Honduras","El Salvador","St.Vincent","Mexico","USA",
"Costa Rica"
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
