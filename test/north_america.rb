# -*- coding: euc-jp -*-
require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/mexico/mexico/squad/",
"http://int.soccerway.com/teams/united-states/united-states-of-america/squad/",
"http://int.soccerway.com/teams/panama/panama/squad/",
"http://int.soccerway.com/teams/haiti/haiti/squad/",
"http://int.soccerway.com/teams/honduras/honduras/squad/",
"http://int.soccerway.com/teams/costa-rica/costa-rica/squad/",
"http://int.soccerway.com/teams/el-salvador/el-salvador/squad/",
"http://int.soccerway.com/teams/canada/canada/squad/",
"http://int.soccerway.com/teams/trinidad-and-tobago/trinidad-and-tobago/squad/",
"http://int.soccerway.com/teams/guatemala/guatemala/squad/",
"http://int.soccerway.com/teams/jamaica/jamaica/squad/",
"http://int.soccerway.com/teams/st-vincent-and-the-grenadines/st-vincent-and-the-grenadines/squad/"
]

national = [
"Mexico","USA","Panama","Haiti","Honduras",
"Costa Rica","El Salvador","Canada","Trinidad and Tobago","Guateamala",
"Jamaica","St.Vincent and the Grenadines"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 0..(url.size-1)
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
