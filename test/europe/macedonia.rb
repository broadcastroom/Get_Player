require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/get_from_game'

url = [
"http://int.soccerway.com/matches/2015/03/27/europe/european-championship-qualification/macedonia-fyr/belarus/1653247/",
"http://int.soccerway.com/matches/2015/10/09/europe/european-championship-qualification/macedonia-fyr/ukraine/1653359/",
"http://int.soccerway.com/matches/2015/09/08/europe/european-championship-qualification/macedonia-fyr/spain/1653343/",
"http://int.soccerway.com/matches/2014/11/15/europe/european-championship-qualification/macedonia-fyr/slovakia/1653230/"
]

national = [
"FYR Macedonia"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 0..(url.size-1)
  test_doc = Get_From_Game.crawl(url[j])
  player_url = Get_From_Game.get_player_url(test_doc)
  team = Get_From_Game.get_player_team(player_url)
  position = Get_From_Game.get_player_position(player_url)
  age = Get_From_Game.get_player_age(player_url)
  name = Get_From_Game.get_player_name(player_url)
  team_url = Get_From_Game.get_team_url(player_url)
  team_national = Get_From_Game.get_team_national(team_url)
  division = Get_From_Game.get_team_division(player_url)

  st = connection.prepare("insert into player (name,age,position,national,team,team_national,division) values (?,?,?,?,?,?,?) on duplicate key update age=?,position=?,team=?,team_national=?,division=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],position[i],national[0],team[i],team_national[i],division[i],age[i],position[i],team[i],team_national[i],division[i]
  end

end

st.close()
connection.close()
