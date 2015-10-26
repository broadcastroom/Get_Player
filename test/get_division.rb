require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../lib/get_player'

url = [
"http://int.soccerway.com/teams/korea-republic/korea-republic/squad/",
"http://int.soccerway.com/teams/japan/japan/squad/"
]

national = [
"Korea Republic","Japan"
]

  test_doc = Get_Player.crawl(url[0])
  player_url = Get_Player.get_player_url(test_doc)
p Get_Player.get_team_division(player_url)
