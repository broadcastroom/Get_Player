module Get_From_Game
  require 'open-uri'
  require 'kconv'
  require 'nokogiri'

  def self.crawl(start_url)
    doc = Nokogiri::HTML(open(start_url, &:read))
    return doc
  end

  def self.get_player_url(url_doc)
    url = []
    
    url_odd = url_doc.xpath('//div[@class="container left"]/table[@class="playerstats lineups table"]/tbody/tr[@class="odd"]/td[@class="player large-link"]/a/@href')
    for i in 0..(url_odd.size-1)
      url.push(url_odd[i].text)
    end

    url_even = url_doc.xpath('//div[@class="container left"]/table[@class="playerstats lineups table"]/tbody/tr[@class="even"]/td[@class="player large-link"]/a/@href')
    for i in 0..(url_even.size-1)
      url.push(url_even[i].text)
    end
    
    return url
  end

  def self.get_player_team(player_url)
    team = []
    
    for i in 0..(player_url.size-1)
      team_doc = self.crawl('http://int.soccerway.com'+player_url[i])
      team_season = team_doc.xpath('//tbody/tr[@class="odd"]/td[@class="team"]/a/@title')[0]
      if team_season then
        team.push(team_season.text)
      elsif !team_season then
        team.push(team_season)
      end
    end
    
    return team
  end

  def self.get_team_url(player_url)
    team_url = []
    
    for i in 0..(player_url.size-1)
      player_doc = self.crawl('http://int.soccerway.com'+player_url[i])
      team_doc = player_doc.xpath('//tbody/tr[@class="odd"]/td[@class="team"]/a/@href')[0]
      if team_doc then
        team_url.push(team_doc.text)
      elsif !team_doc then
        team_url.push(team_doc)
      end
    end
    
    return team_url
  end

  def self.get_team_national(team_url)
    team_national = []
    dt_dd = {}

    for i in 0..(team_url.size-1)
      if team_url[i] then
        team_doc = self.crawl('http://int.soccerway.com'+team_url[i])
        dt = team_doc.xpath('//div[@class="clearfix"]/dl/dt')
        dd = team_doc.xpath('//div[@class="clearfix"]/dl/dd')

        for i in 0..(dt.size-1)
          dt_dd[dt[i].text] = dd[i].text
        end
        
        team_national.push(dt_dd["Country"])
      elsif !team_url[i] then
        team_national.push(team_url[i])
      end

    end
    
    return team_national
  end

  def self.get_team_division(player_url)
    division = []
    
    for i in 0..(player_url.size-1)
      if player_url[i] then
        player_doc = self.crawl('http://int.soccerway.com'+player_url[i])
        division_doc = player_doc.xpath('//tbody/tr[@class="odd"]/td[@class="competition"]/a/@title')[0]
        if division_doc then
          division.push(division_doc.text)
        elsif !division_doc then
          division.push(division_doc)
        end
      end
    end
    return division
  end

  def self.get_player_name(player_url)
    name = []
    dt_dd = {}
    
    for i in 0..(player_url.size-1)
      if player_url[i] then
        player_doc = self.crawl('http://int.soccerway.com'+player_url[i])
        dt = player_doc.xpath('//div[@class="clearfix"]/dl/dt')
        dd = player_doc.xpath('//div[@class="clearfix"]/dl/dd')
        
        for i in 0..(dt.size-1)
          dt_dd[dt[i].text] = dd[i].text
        end

        name.push(dt_dd["First name"]+" "+dt_dd["Last name"])
      elsif !player_url[i] then
        name.push(player_url[i])
      end

    end

    return name
  end
  
  def self.get_player_age(player_url)
    age = []
    dt_dd = {}
    
    for i in 0..(player_url.size-1)
      if player_url[i] then
        player_doc = self.crawl('http://int.soccerway.com'+player_url[i])
        dt = player_doc.xpath('//div[@class="clearfix"]/dl/dt')
        dd = player_doc.xpath('//div[@class="clearfix"]/dl/dd')
        
        for i in 0..(dt.size-1)
          dt_dd[dt[i].text] = dd[i].text
        end

        age.push(dt_dd["Age"])

      elsif !player_url[i] then
        age.push(player_url[i])
      end

    end

    return age
  end

  def self.get_player_position(player_url)
    position = []
    dt_dd = {}
    
    for i in 0..(player_url.size-1)
      if player_url[i] then
        player_doc = self.crawl('http://int.soccerway.com'+player_url[i])
        dt = player_doc.xpath('//div[@class="clearfix"]/dl/dt')
        dd = player_doc.xpath('//div[@class="clearfix"]/dl/dd')
        
        for i in 0..(dt.size-1)
          dt_dd[dt[i].text] = dd[i].text
        end

        position.push(dt_dd["Position"])

      elsif !player_url[i] then
        position.push(player_url[i])
      end

    end
    return position
  end
end
