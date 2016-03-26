require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
  "http://www.transfermarkt.co.uk/hungary/leistungsdaten/verein/3468/plus/0?reldata=EMQ%262014"
]

national = [
  "Hungary"
]

for j in 0..(url.size-1)
  k = 0
  p national[j]
  p j*100/national.length
  test_doc = Transfer.crawl(url[j])
  p minutes = Transfer.get_player_minutes(test_doc)
  p player_url = Transfer.get_player_url(test_doc)

  while minutes[k] != nil do
    if ! /\d+/.match(minutes[k])
      minutes.delete_at(k)
      player_url.delete_at(k)
      k -= 1
    end
    k += 1
  end

  p minutes
  p player_url

  player_doc = Transfer.get_player_doc(player_url)
  # team = Transfer.get_player_team(player_doc)
  # position = Transfer.get_player_position(player_doc)
  # age = Transfer.get_player_age(player_doc)
  # height = Transfer.get_player_height(player_doc)
  # p name = Transfer.get_player_name(player_doc)
  p team_url = Transfer.get_team_url(player_doc)
  team_doc = Transfer.get_team_doc(team_url)
  p team_name = Transfer.get_player_team(player_doc)
  p team_national = Transfer.get_team_national(team_doc)
  p division = Transfer.get_team_division(team_doc)

end
