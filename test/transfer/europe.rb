require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/hungary/leistungsdaten/verein/3468/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/northern-ireland/leistungsdaten/verein/5674/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/germany/leistungsdaten/verein/3262/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/belgium/leistungsdaten/verein/3382/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/portugal/leistungsdaten/verein/3300/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/spain/leistungsdaten/verein/3375/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/wales/leistungsdaten/verein/3864/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/england/leistungsdaten/verein/3299/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/austria/leistungsdaten/verein/3383/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/switzerland/leistungsdaten/verein/3384/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/netherlands/leistungsdaten/verein/3379/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/czech-republic/leistungsdaten/verein/3445/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/croatia/leistungsdaten/verein/3556/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/italy/leistungsdaten/verein/3376/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/slovakia/leistungsdaten/verein/3503/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/france/leistungsdaten/verein/3377/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/ukraine/leistungsdaten/verein/3699/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/russia/leistungsdaten/verein/3448/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/denmark/leistungsdaten/verein/3436/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/bosnia-h-/leistungsdaten/verein/3446/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/albania/leistungsdaten/verein/3561/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/norway/leistungsdaten/verein/3440/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/turkey/leistungsdaten/verein/3381/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/scotland/leistungsdaten/verein/3380/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/poland/leistungsdaten/verein/3442/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/sweden/leistungsdaten/verein/3557/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/slovenia/leistungsdaten/verein/3588/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/israel/leistungsdaten/verein/5547/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/ireland/leistungsdaten/verein/3509/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/serbia/leistungsdaten/verein/3438/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/finland/leistungsdaten/verein/3443/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/bulgaria/leistungsdaten/verein/3394/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/faroe-islands/leistungsdaten/verein/9173/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/estonia/leistungsdaten/verein/6133/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/armenia/leistungsdaten/verein/6219/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/belarus/leistungsdaten/verein/3450/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/latvia/leistungsdaten/verein/3555/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/azerbaijan/leistungsdaten/verein/8605/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/cyprus/leistungsdaten/verein/3668/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/lithuania/leistungsdaten/verein/3851/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/macedonia/leistungsdaten/verein/5148/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/moldova/leistungsdaten/verein/6090/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/kazakhstan/leistungsdaten/verein/9110/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/iceland/leistungsdaten/verein/3574/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/luxembourg/leistungsdaten/verein/3580/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/montenegro/leistungsdaten/verein/11953/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/liechtenstein/leistungsdaten/verein/5673/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/greece/leistungsdaten/verein/3378/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/georgia/leistungsdaten/verein/3669/plus/0?reldata=EMQ%262014",
"http://www.transfermarkt.co.uk/romania/leistungsdaten/verein/3447/plus/0?reldata=EMQ%262014"
]

national = [
"Hungary","Northern Ireland","Germany","Belgium","Portugal",
"Spain","Wales","England","Austria","Switzerland",
"Netherlands","Czech Republic","Croatia","Italy","Slovakia",
"France","Ukraine","Russia","Denmark","Bosnia Herzegovina",
"Albania","Norway","Turkey","Scotland","Poland",
"Sweden","Slovenia","Israel","Ireland","Serbia",
"Finland","Bulgaria","Feloe Islands","Estonia","Armenia",
"Belarus","Latvia","Azerbaijan","Cyprus","Lithuania",
"Macedonia","Moldova","Kazakhstan","Iceland","Luxembourg",
"Montenegro","Liechtenstein","Greece","Georgia","Romania"
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
  minutes = Transfer.get_player_minutes(test_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?) on duplicate key update team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],team[i],team_national[i],division[i],minutes[i],team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
