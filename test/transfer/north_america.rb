require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/trinidad/leistungsdaten/verein/7149/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/panama/leistungsdaten/verein/3577/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/guatemala/leistungsdaten/verein/13342/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/el-salvador/leistungsdaten/verein/13951/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/st-vincent/leistungsdaten/verein/17762/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/usatm/leistungsdaten/verein/3505/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/united-states/leistungsdaten/verein/3505/plus/0?reldata=CCPL%262015",
"http://www.transfermarkt.co.uk/united-states/leistungsdaten/verein/3505/plus/0?reldata=GC15%262014",
"http://www.transfermarkt.co.uk/honduras/leistungsdaten/verein/3590/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/jamaika/leistungsdaten/verein/3671/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/canada/leistungsdaten/verein/3510/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/antigua-and-barbuda/leistungsdaten/verein/16028/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/saint-kitts-and-nevis/leistungsdaten/verein/17760/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/aruba/leistungsdaten/verein/17749/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/guyana/leistungsdaten/verein/15736/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/martinique/leistungsdaten/verein/19758/plus/0?reldata=CC14%262014",
"http://www.transfermarkt.co.uk/costa-rica/leistungsdaten/verein/8497/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/haiti/leistungsdaten/verein/14161/plus/0?reldata=WMQ3%262016",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303/plus/0?reldata=GC15%262014"
]

national = [
"Trinidad and Tobago","Panama","Guatemala","El Salvador",
"St.Vincent","Mexico","USA","USA","USA",
"Honduras","Jamaica","Canada","Antigua and Barbuda","Saint kitts and Nevis",
"Aruba","Guyana","Martinique","Costa Rica","Haiti",
"Mexico"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 6..(url.size-1)
  k=0
  p national[j]
  p j*100/national.length
  test_doc = Transfer.crawl(url[j])
  minutes = Transfer.get_player_minutes(test_doc)
  player_url = Transfer.get_player_url(test_doc)

  while minutes[k] != nil do
    if ! /\d+/.match(minutes[k])
      minutes.delete_at(k)
      player_url.delete_at(k)
      k -= 1
    end
    k += 1
  end

  player_doc = Transfer.get_player_doc(player_url)
  team = Transfer.get_player_team(player_doc)
  position = Transfer.get_player_position(player_doc)
  age = Transfer.get_player_age(player_doc)
  height = Transfer.get_player_height(player_doc)
  p name = Transfer.get_player_name(player_doc)
  team_url = Transfer.get_team_url(player_doc)
  team_doc = Transfer.get_team_doc(team_url)
  team_national = Transfer.get_team_national(team_doc)
  division = Transfer.get_team_division(team_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"North America",team[i],team_national[i],division[i],minutes[i],"North America",team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
