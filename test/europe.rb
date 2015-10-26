require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/azerbaijan/azerbaijan/squad/",
"http://int.soccerway.com/teams/bosnia-herzegovina/bosnia-herzegovina/squad/",
"http://int.soccerway.com/teams/czech-republic/czech-republic/squad/",
"http://int.soccerway.com/teams/switzerland/switzerland/squad/",
"http://int.soccerway.com/teams/germany/germany/squad/",
"http://int.soccerway.com/teams/norway/norway/squad/",
"http://int.soccerway.com/teams/slovakia/slovakia/squad/",
"http://int.soccerway.com/teams/slovenia/slovenia/squad/",
"http://int.soccerway.com/teams/montenegro/montenegro/squad/",
"http://int.soccerway.com/teams/poland/poland/squad/",
"http://int.soccerway.com/teams/armenia/armenia/squad/",
"http://int.soccerway.com/teams/denmark/denmark/squad/",
"http://int.soccerway.com/teams/serbia/serbia/squad/",
"http://int.soccerway.com/teams/spain/spain/squad/",
"http://int.soccerway.com/teams/finland/finland/squad/",
"http://int.soccerway.com/teams/sweden/sweden/squad/",
"http://int.soccerway.com/teams/turkey/turkey/squad/",
"http://int.soccerway.com/teams/italy/italy/squad/",
"http://int.soccerway.com/teams/england/england/squad/",
"http://int.soccerway.com/teams/netherlands/netherlands/squad/",
"http://int.soccerway.com/teams/iceland/iceland/squad/",
"http://int.soccerway.com/teams/kazakhstan/kazakhstan/squad/",
"http://int.soccerway.com/teams/northern-ireland/northern-ireland/squad/",
"http://int.soccerway.com/teams/georgia/georgia/squad/",
"http://int.soccerway.com/teams/belarus/belarus/squad/",
"http://int.soccerway.com/teams/estonia/estonia/squad/",
"http://int.soccerway.com/teams/portugal/portugal/squad/",
"http://int.soccerway.com/teams/ukraine/ukraine/squad/",
"http://int.soccerway.com/teams/russia/russia/squad/",
"http://int.soccerway.com/teams/israel/israel/squad/",
"http://int.soccerway.com/teams/cyprus/cyprus/squad/",
"http://int.soccerway.com/teams/croatia/croatia/squad/",
"http://int.soccerway.com/teams/wales/wales/squad/",
"http://int.soccerway.com/teams/france/france/squad/",
"http://int.soccerway.com/teams/latvia/latvia/squad/",
"http://int.soccerway.com/teams/macedonia-fyr/macedonia-fyr/squad/",
"http://int.soccerway.com/teams/ireland-republic/ireland-republic/squad/",
"http://int.soccerway.com/teams/scotland/scotland/squad/",
"http://int.soccerway.com/teams/lithuania/lithuania/squad/",
"http://int.soccerway.com/teams/romania/romania/squad/",
"http://int.soccerway.com/teams/hungary/hungary/squad/",
"http://int.soccerway.com/teams/greece/greece/squad/",
"http://int.soccerway.com/teams/austria/austria/squad/",
"http://int.soccerway.com/teams/bulgaria/bulgaria/squad/",
"http://int.soccerway.com/teams/albania/albania/squad/",
"http://int.soccerway.com/teams/belgium/belgium/squad/"
]

national = [
"Azerbaijan","Bosnia and Herzegovina","Czech Republic","Switzerland","Germany",
"Norway","Slovakia","Slovenia","Montenegro","Poland",
"Armenia","Denmark","Serbia","Spain","Finland",
"Sweden","Turkey","Italy","England","Netherlands",
"Iceland","Kazakhstan","Northern Ireland","Georgia","Belarus",
"Estonia","Portugal","Ukraine","Russia","Israel",
"Cyprus","Croatia","Wales","France","Latvia",
"FYR Macedonia","Republic of Ireland","Scotland","Lithuania","Romania",
"Hungary","Greece","Austria","Bulgaria","Albania",
"Belgium"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 45..(url.size-1)
  test_doc = Get_Player.crawl(url[j])
  player_url = Get_Player.get_player_url(test_doc)
  team = Get_Player.get_player_team(player_url)
  position = Get_Player.get_player_position(test_doc)
  age = Get_Player.get_player_age(test_doc)
  name = Get_Player.get_player_name(player_url)
  team_url = Get_Player.get_team_url(player_url)
  team_national = Get_Player.get_team_national(team_url)
  minutes = Get_Player.get_player_minutes(test_doc)
  division = Get_Player.get_team_division(player_url)

  st = connection.prepare("insert into player (name,age,position,national,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?) on duplicate key update team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],position[i],national[j],team[i],team_national[i],division[i],minutes[i],team[i],team_national[i],division[i],minutes[i]
  end

end

st.close()
connection.close()
