require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/north-korea/leistungsdaten/verein/15457/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/south-korea/leistungsdaten/verein/3589/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/china/leistungsdaten/verein/5598/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/iraq/leistungsdaten/verein/3560/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/united-arab-emirates/leistungsdaten/verein/5147/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/saudi-arabia/leistungsdaten/verein/3807/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/oman/leistungsdaten/verein/14165/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/qatar/leistungsdaten/verein/14162/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/bahrain/leistungsdaten/verein/7214/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/jordan/leistungsdaten/verein/15737/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/palestine/leistungsdaten/verein/17758/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/kuwait/leistungsdaten/verein/3432/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/syria/leistungsdaten/verein/13674/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/lebanon/leistungsdaten/verein/3586/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/thailand/leistungsdaten/verein/5676/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/singapore/leistungsdaten/verein/15357/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/iran/leistungsdaten/verein/3582/plus/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/hong-kong/leistungsdaten/verein/15977/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/chinese-taipei-taiwan-/leistungsdaten/verein/15363/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/philippinen/leistungsdaten/verein/15234/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/australia/leistungsdaten/verein/3433/plus/0?reldata=%262014",
"http://www.transfermarkt.co.uk/uzbekistan/leistungsdaten/verein/3563/plus/0?reldata=%262014"
]

national = [
"North Korea","South Korea","China",
"Iraq","UAE","Saudi Arabia","Oman","Qatar",
"Bahrain","Jordan","Palestine","Kuwait","Syria",
"Lebanon","Thailand","Singapore","Iran","Hong Kong",
"Chinese Taipei","Philippines","Australia","Uzbekistan"
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
