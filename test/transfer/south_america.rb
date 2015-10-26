require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/argentina/startseite/verein/3437",
"http://www.transfermarkt.co.uk/colombia/startseite/verein/3816",
"http://www.transfermarkt.co.uk/brazil/startseite/verein/3439",
"http://www.transfermarkt.co.uk/chile/startseite/verein/3700",
"http://www.transfermarkt.co.uk/uruguay/startseite/verein/3449",
"http://www.transfermarkt.co.uk/ecuador/startseite/verein/5750",
"http://www.transfermarkt.co.uk/peru/startseite/verein/3584",
"http://www.transfermarkt.co.uk/paraguay/startseite/verein/3581",
"http://www.transfermarkt.co.uk/bolivia/startseite/verein/5233",
"http://www.transfermarkt.co.uk/venezuela/startseite/verein/3504"
]

national = [
"Argentina","Colombia","Brazil","Chile","Uruguay",
"Ecuador","Peru","Paraguay","Bolivia","Venezuela"
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

  st = connection.prepare("insert into transfer (name,age,height,position,national,team,team_national,division) values (?,?,?,?,?,?,?,?) on duplicate key update team=?,team_national=?,division=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],team[i],team_national[i],division[i],team[i],team_national[i],division[i]
  end
end

st.close()
connection.close()
