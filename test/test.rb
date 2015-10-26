require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../lib/get_player'

url = 'http://int.soccerway.com/teams/japan/japan/1348/squad/'

test_doc = Get_Player.crawl(url)
player_url = Get_Player.get_player_url(test_doc)
p Get_Player.get_player_name(player_url)

