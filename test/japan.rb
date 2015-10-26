require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = "http://int.soccerway.com/teams/japan/japan/squad/"

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

  test_doc = Get_Player.crawl(url)
  player_url = Get_Player.get_player_url(test_doc)
  team = Get_Player.get_player_team(player_url)
  position = Get_Player.get_player_position(test_doc)
  age = Get_Player.get_player_age(test_doc)
  name = Get_Player.get_player_name(player_url)
  team_url = Get_Player.get_team_url(player_url)
  team_national = Get_Player.get_team_national(team_url)
  minutes = Get_Player.get_player_minutes(test_doc)

  st = connection.prepare("insert into player (name,age,position,national,team,team_national,minutes) values (?,?,?,?,?,?,?)")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],position[i],"Japan",team[i],team_national[i],minutes[i]
  end

st.close()
connection.close()
