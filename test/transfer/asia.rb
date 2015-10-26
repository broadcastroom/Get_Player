require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/australia/startseite/verein/3433",
"http://www.transfermarkt.co.uk/north-korea/startseite/verein/15457",
"http://www.transfermarkt.co.uk/south-korea/startseite/verein/3589",
"http://www.transfermarkt.co.uk/china/startseite/verein/5598?saison_id=2015",
"http://www.transfermarkt.co.uk/uzbekistan/startseite/verein/3563?saison_id=2015",
"http://www.transfermarkt.co.uk/iran/startseite/verein/3582?saison_id=2015",
"http://www.transfermarkt.co.uk/iraq/startseite/verein/3560?saison_id=2015",
"http://www.transfermarkt.co.uk/united-arab-emirates/startseite/verein/5147?saison_id=2015",
"http://www.transfermarkt.co.uk/saudi-arabia/startseite/verein/3807?saison_id=2015",
"http://www.transfermarkt.co.uk/oman/startseite/verein/14165?saison_id=2015",
"http://www.transfermarkt.co.uk/qatar/startseite/verein/14162?saison_id=2015",
"http://www.transfermarkt.co.uk/bahrain/startseite/verein/7214?saison_id=2015",
"http://www.transfermarkt.co.uk/jordan/startseite/verein/15737?saison_id=2015",
"http://www.transfermarkt.co.uk/palestine/startseite/verein/17758?saison_id=2015",
"http://www.transfermarkt.co.uk/kuwait/startseite/verein/3432?saison_id=2015",
"http://www.transfermarkt.co.uk/syria/startseite/verein/13674",
"http://www.transfermarkt.co.uk/philippines/startseite/verein/15234",
"http://www.transfermarkt.co.uk/lebanon/startseite/verein/3586",
"http://www.transfermarkt.co.uk/thailand/startseite/verein/5676",
"http://www.transfermarkt.co.uk/singapore/startseite/verein/15357"
]

national = [
"Australia","North Korea","South Korea","China","Uzbekistan",
"Iran","Iraq","UAE","Saudi Arabia","Oman",
"Qatar","Bahrain","Jordan","Palestine","Kuwait",
"Syria","Philippines","Lebanon","Thailand","Singapore"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 15..(url.size-1)
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
