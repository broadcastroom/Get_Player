require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/hungary/startseite/verein/3468",
"http://www.transfermarkt.co.uk/northern-ireland/startseite/verein/5674",
"http://www.transfermarkt.co.uk/germany/startseite/verein/3262",
"http://www.transfermarkt.co.uk/belgium/startseite/verein/3382",
"http://www.transfermarkt.co.uk/portugal/startseite/verein/3300",
"http://www.transfermarkt.co.uk/spain/startseite/verein/3375",
"http://www.transfermarkt.co.uk/wales/startseite/verein/3864",
"http://www.transfermarkt.co.uk/england/startseite/verein/3299",
"http://www.transfermarkt.co.uk/austria/startseite/verein/3383",
"http://www.transfermarkt.co.uk/switzerland/startseite/verein/3384",
"http://www.transfermarkt.co.uk/romania/startseite/verein/3447",
"http://www.transfermarkt.co.uk/netherlands/startseite/verein/3379",
"http://www.transfermarkt.co.uk/czech-republic/startseite/verein/3445",
"http://www.transfermarkt.co.uk/croatia/startseite/verein/3556",
"http://www.transfermarkt.co.uk/italy/startseite/verein/3376",
"http://www.transfermarkt.co.uk/slovakia/startseite/verein/3503",
"http://www.transfermarkt.co.uk/france/startseite/verein/3377",
"http://www.transfermarkt.co.uk/iceland/startseite/verein/3574",
"http://www.transfermarkt.co.uk/ukraine/startseite/verein/3699",
"http://www.transfermarkt.co.uk/russia/startseite/verein/3448",
"http://www.transfermarkt.co.uk/denmark/startseite/verein/3436",
"http://www.transfermarkt.co.uk/bosnia-h-/startseite/verein/3446",
"http://www.transfermarkt.co.uk/albania/startseite/verein/3561",
"http://www.transfermarkt.co.uk/norway/startseite/verein/3440",
"http://www.transfermarkt.co.uk/turkey/startseite/verein/3381",
"http://www.transfermarkt.co.uk/scotland/startseite/verein/3380",
"http://www.transfermarkt.co.uk/poland/startseite/verein/3442",
"http://www.transfermarkt.co.uk/greece/startseite/verein/3378",
"http://www.transfermarkt.co.uk/sweden/startseite/verein/3557",
"http://www.transfermarkt.co.uk/slovenia/startseite/verein/3588",
"http://www.transfermarkt.co.uk/israel/startseite/verein/5547",
"http://www.transfermarkt.co.uk/ireland/startseite/verein/3509",
"http://www.transfermarkt.co.uk/serbia/startseite/verein/3438",
"http://www.transfermarkt.co.uk/finland/startseite/verein/3443",
"http://www.transfermarkt.co.uk/montenegro/startseite/verein/11953",
"http://www.transfermarkt.co.uk/bulgaria/startseite/verein/3394",
"http://www.transfermarkt.co.uk/faroe-islands/startseite/verein/9173",
"http://www.transfermarkt.co.uk/estonia/startseite/verein/6133",
"http://www.transfermarkt.co.uk/armenia/startseite/verein/6219",
"http://www.transfermarkt.co.uk/belarus/startseite/verein/3450",
"http://www.transfermarkt.co.uk/latvia/startseite/verein/3555",
"http://www.transfermarkt.co.uk/azerbaijan/startseite/verein/8605",
"http://www.transfermarkt.co.uk/georgia/startseite/verein/3669",
"http://www.transfermarkt.co.uk/cyprus/startseite/verein/3668",
"http://www.transfermarkt.co.uk/lithuania/startseite/verein/3851",
"http://www.transfermarkt.co.uk/macedonia/startseite/verein/5148",
"http://www.transfermarkt.co.uk/moldova/startseite/verein/6090",
"http://www.transfermarkt.co.uk/kazakhstan/startseite/verein/9110"
]

national = [
"Hungary","Northern Ireland","Germany","Belgium","Portugal",
"Spain","Wales","England","Austria","Switzerland",
"Romania","Netherlands","Czech Republic","Croatia","Italy",
"Slovakia","France","Iceland","Ukraine","Russia",
"Denmark","Bosnia Herzegovina","Albania","Norway","Turkey",
"Scotland","Poland","Greece","Sweden","Slovenia",
"Israel","Ireland","Serbia","Finland","Montenegro",
"Bulgaria","Feloe Islands","Estonia","Armenia","Belarus",
"Latvia","Azerbaijan","Georgia","Cyprus","Lithuania",
"Macedonia","Moldova","Kazakhstan"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 31..(url.size-1)
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
