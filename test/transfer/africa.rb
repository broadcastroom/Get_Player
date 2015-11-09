require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/uganda/leistungsdaten/verein/13497/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/egypt/leistungsdaten/verein/3672/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/nigeria/leistungsdaten/verein/3444/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/togo/leistungsdaten/verein/3815/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/morocco/leistungsdaten/verein/3575/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/mauritania/leistungsdaten/verein/14238/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/liberia/leistungsdaten/verein/9172/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/angola/leistungsdaten/verein/3585/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/benin/leistungsdaten/verein/3955/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/ethiopia/leistungsdaten/verein/13941/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/botswana/leistungsdaten/verein/15229/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/burundi/leistungsdaten/verein/13943/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/niger/leistungsdaten/verein/14163/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/namibia/leistungsdaten/verein/3573/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/libya/leistungsdaten/verein/6602/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/mozambique/leistungsdaten/verein/5129/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/madagascar/leistungsdaten/verein/14635/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/kenya/leistungsdaten/verein/8987/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/swaziland/leistungsdaten/verein/13675/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/tanzania/leistungsdaten/verein/14666/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/comoros/leistungsdaten/verein/16430/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/zambia/leistungsdaten/verein/3703/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/algeria/leistungsdaten/verein/3614/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/ivory-coast/leistungsdaten/verein/3591/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/ghana/leistungsdaten/verein/3441/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/tunisia/leistungsdaten/verein/3670/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/senegal/leistungsdaten/verein/3499/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/cape-verde/leistungsdaten/verein/4311/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/cameroon/leistungsdaten/verein/3434/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/congo/leistungsdaten/verein/3702/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/dr-congo/leistungsdaten/verein/3854/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/mali/leistungsdaten/verein/3674/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/gabon/leistungsdaten/verein/5704/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/equat-guinea/leistungsdaten/verein/13485/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/south-africa/leistungsdaten/verein/3806/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/guinea/leistungsdaten/verein/3856/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/burkina-faso/leistungsdaten/verein/5872/plus/0?reldata=AC15%262014",
"http://www.transfermarkt.co.uk/chad/leistungsdaten/verein/13978/plus/0?reldata=WMQ2%262016",
"http://www.transfermarkt.co.uk/sudan/leistungsdaten/verein/13313/plus/0?reldata=AFCQ%262014",
"http://www.transfermarkt.co.uk/rwanda/leistungsdaten/verein/3855/plus/0?reldata=AFCQ%262014"
]

national = [
"Uganda","Egypt","Nigeria","Togo","Morocco",
"Mauritania","Liberia","Angola","Benin","Ethiopia",
"Botswana","Burundi","Niger","Namibia","Libya",
"Mozambique","Madagascar","Kenya","Swaziland","Tanzania",
"Comoros","Zambia","Algeria","Ivory Coast","Ghana",
"Tunisia","Senegal","Cape Verde","Cameroon","Congo",
"DR Congo","Mali","Gabon","Equatorial Guinea","South Africa",
"Guinea","Burkina Faso","Chad","Sudan","Rwanda"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 38..(url.size-1)
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

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"Africa",team[i],team_national[i],division[i],minutes[i],"Africa",team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
