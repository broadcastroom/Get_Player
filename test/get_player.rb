require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/korea-republic/korea-republic/squad/",
"http://int.soccerway.com/teams/mexico/mexico/squad/",
"http://int.soccerway.com/teams/chile/chile/squad/",
"http://int.soccerway.com/teams/united-states/united-states-of-america/squad/",
"http://int.soccerway.com/teams/cape-verde-islands/cape-verde-islands/squad/",
"http://int.soccerway.com/teams/colombia/colombia/squad/",
"http://int.soccerway.com/teams/panama/panama/squad/",
"http://int.soccerway.com/teams/paraguay/paraguay/squad/",
"http://int.soccerway.com/teams/ecuador/ecuador/squad/",
"http://int.soccerway.com/teams/bolivia/bolivia/squad/",
"http://int.soccerway.com/teams/argentina/argentina/squad/",
"http://int.soccerway.com/teams/uruguay/uruguay/squad/",
"http://int.soccerway.com/teams/jamaica/jamaica/squad/",
"http://int.soccerway.com/teams/peru/peru/squad/",
"http://int.soccerway.com/teams/venezuela/venezuela/squad/",
"http://int.soccerway.com/teams/bulgaria/bulgaria/squad/",
"http://int.soccerway.com/teams/japan/japan/squad/",
"http://int.soccerway.com/teams/china-pr/china-pr/squad/",
"http://int.soccerway.com/teams/australia/australia/squad/",
"http://int.soccerway.com/teams/united-arab-emirates/united-arab-emirates/squad/",
"http://int.soccerway.com/teams/saudi-arabia/saudi-arabia/squad/",
"http://int.soccerway.com/teams/qatar/qatar/squad/",
"http://int.soccerway.com/teams/iran/iran/squad/",
"http://int.soccerway.com/teams/uzbekistan/uzbekistan/squad/"
]

national = [
"Korea Republic","Mexico","Chile","USA","Cape Verde Islands",
"Colombia","Panama","Paraguay","Ecuador","Bolivia",
"Argentina","Uruguay","Jamaica","Peru","Venezuela",
"Bulgaria","Japan","China","Australia","UAE",
"Saudi Arabia","Qatar","Iran","Uzbekistan"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 19..(url.size-1)
  test_doc = Get_Player.crawl(url[j])
  player_url = Get_Player.get_player_url(test_doc)
  team = Get_Player.get_player_team(player_url)
  position = Get_Player.get_player_position(test_doc)
  age = Get_Player.get_player_age(test_doc)
  name = Get_Player.get_player_name(test_doc)
  team_url = Get_Player.get_team_url(player_url)
  team_national = Get_Player.get_team_national(team_url)
  minutes = Get_Player.get_player_minutes(test_doc)

  st = connection.prepare("insert into player (name,age,position,national,team,team_national,minutes) values (?,?,?,?,?,?,?)")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],position[i],national[j],team[i],team_national[i],minutes[i]
  end

end

st.close()
connection.close()
