require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/korea-republic/korea-republic/squad/",
"http://int.soccerway.com/teams/japan/japan/squad/",
"http://int.soccerway.com/teams/china-pr/china-pr/squad/",
"http://int.soccerway.com/teams/australia/australia/squad/",
"http://int.soccerway.com/teams/united-arab-emirates/united-arab-emirates/squad/",
"http://int.soccerway.com/teams/saudi-arabia/saudi-arabia/squad/",
"http://int.soccerway.com/teams/qatar/qatar/squad/",
"http://int.soccerway.com/teams/iran/iran/squad/",
"http://int.soccerway.com/teams/uzbekistan/uzbekistan/squad/",
"http://int.soccerway.com/teams/jordan/jordan/squad/",
"http://int.soccerway.com/teams/syria/syria/squad/",
"http://int.soccerway.com/teams/iraq/iraq/squad/",
"http://int.soccerway.com/teams/korea-dpr/korea-dpr/squad/",
"http://int.soccerway.com/teams/philippines/philippines/squad/",
"http://int.soccerway.com/teams/chinese-taipei/chinese-taipei/squad/",
"http://int.soccerway.com/teams/thailand/thailand/squad/",
"http://int.soccerway.com/teams/lebanon/lebanon/squad/",
"http://int.soccerway.com/teams/oman/oman/squad/",
"http://int.soccerway.com/teams/kuwait/kuwait/squad/",
"http://int.soccerway.com/teams/palestine/palestine/squad/",
"http://int.soccerway.com/teams/kyrgyzstan/kyrgyzstan/squad/",
"http://int.soccerway.com/teams/singapore/singapore/squad/",
"http://int.soccerway.com/teams/vietnam/vietnam/squad/",
"http://int.soccerway.com/teams/myanmar/myanmar/squad/",
"http://int.soccerway.com/teams/macao/macao/squad/",
"http://int.soccerway.com/teams/hong-kong/hong-kong/squad/",
"http://int.soccerway.com/teams/east-timor/timor-leste/squad/",
"http://int.soccerway.com/teams/malaysia/malaysia/squad/",
"http://int.soccerway.com/teams/yemen/yemen/squad/",
"http://int.soccerway.com/teams/turkmenistan/turkmenistan/squad/"
]

national = [
"Korea Republic","Japan","China","Australia","UAE",
"Saudi Arabia","Qatar","Iran","Uzbekistan","Jordan",
"Syria","Iraq","Korea DPR","Philippines","Chinese Taipei",
"Thailand","Lebanon","Oman","Kuwait","Palestina",
"Kyrgyzstan","Singapore","Vietnam","Myanmar","Macao",
"Hong Kong","Timor-Leste","Malaysia","Yemen","Turkmenistan"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 29..(url.size-1)
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
