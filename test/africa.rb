# -*- coding: utf-8 -*-
require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/ethiopia/ethiopia/squad/",
"http://int.soccerway.com/teams/egypt/egypt/squad/",
"http://int.soccerway.com/teams/libya/libya/squad/",
"http://int.soccerway.com/teams/angola/angola/squad/",
"http://int.soccerway.com/teams/benin/benin/squad/",
"http://int.soccerway.com/teams/mozambique/mozambique/squad/",
"http://int.soccerway.com/teams/rwanda/rwanda/squad/",
"http://int.soccerway.com/teams/cape-verde-islands/cape-verde-islands/squad/",
"http://int.soccerway.com/teams/ghana/ghana/squad/",
"http://int.soccerway.com/teams/congo/congo/squad/",
"http://int.soccerway.com/teams/equatorial-guinea/equatorial-guinea/squad/",
"http://int.soccerway.com/teams/gabon/gabon/squad/",
"http://int.soccerway.com/teams/burkina-faso/burkina-faso/squad/",
"http://int.soccerway.com/teams/tunisia/tunisia/squad/",
"http://int.soccerway.com/teams/congo-dr/congo-dr/squad/",
"http://int.soccerway.com/teams/zambia/zambia/squad/",
"http://int.soccerway.com/teams/algeria/algeria/squad/",
"http://int.soccerway.com/teams/senegal/senegal/squad/",
"http://int.soccerway.com/teams/south-africa/south-africa/squad/",
"http://int.soccerway.com/teams/cote-divoire/cote-divoire/squad/",
"http://int.soccerway.com/teams/guinea/guinea/squad/",
"http://int.soccerway.com/teams/mali/mali/squad/",
"http://int.soccerway.com/teams/cameroon/cameroon/squad/",
"http://int.soccerway.com/teams/nigeria/nigeria/squad/",
"http://int.soccerway.com/teams/burundi/burundi/squad/",
"http://int.soccerway.com/teams/tanzania/tanzania/squad/",
"http://int.soccerway.com/teams/madagascar/madagascar/squad/",
"http://int.soccerway.com/teams/botswana/botswana/squad/",
"http://int.soccerway.com/teams/kenya/kenya/squad/",
"http://int.soccerway.com/teams/mauritius/mauritius/squad/",
"http://int.soccerway.com/teams/namibia/namibia/squad/",
"http://int.soccerway.com/teams/morocco/morocco/squad/",
"http://int.soccerway.com/teams/niger/niger/squad/",
"http://int.soccerway.com/teams/comoros/comoros/squad/",
"http://int.soccerway.com/teams/liberia/liberia/squad/",
"http://int.soccerway.com/teams/mauritania/mauritania/squad/",
"http://int.soccerway.com/teams/uganda/uganda/squad/",
"http://int.soccerway.com/teams/swaziland/swaziland/squad/",
"http://int.soccerway.com/teams/chad/chad/squad/",
"http://int.soccerway.com/teams/togo/togo/squad/"
]

national = [
"Ethiopia","Egypt","Libya","Angola","Benin",
"Mozambique","Rwanda","Cape Verde Islands","Ghana","Congo",
"Equatorial Guinea","Gabon","Burkina Faso","Tunisia","Congo DR",
"Zambia","Algeria","Senegal","South Africa","Côte d'Ivoire",
"Guinea","Mali","Cameroon","Nigeria","Burundi",
"Tanzania","Madagascar","Botswana","Kenya","Mauritius",
"Namibia","Morocco","Niger","Comoros","Liberia",
"Mauritania","Uganda","Swaziland","Chad","Togo"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 39..(url.size-1)
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
