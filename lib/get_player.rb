module Get_Player
  require 'open-uri'
  require 'kconv'
  require 'nokogiri'

  def self.crawl(start_url)
    doc = Nokogiri::HTML(open(start_url, &:read))
    return doc
  end

  def self.get_player_age(url_doc)
    age = []
    
    age_odd = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="odd"]/td[@class="number age"]')
    for i in 0..(age_odd.size-1)
      age.push(age_odd[i].text)
    end
    
    age_even = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="even"]/td[@class="number age"]')
    for i in 0..(age_even.size-1)
      age.push(age_even[i].text)
    end

    return age
  end

  def self.get_player_position(url_doc)
    position = []
    
    position_odd = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="odd"]/td[@class="position large-link"]/span/@title')
    for i in 0..(position_odd.size-1)
      position.push(position_odd[i].text)
    end
    
    position_even = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="even"]/td[@class="position large-link"]/span/@title')
    for i in 0..(position_even.size-1)
      position.push(position_even[i].text)
    end

    return position
  end

  def self.get_player_minutes(url_doc)
    minutes = []
    
    minutes_odd = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="odd"]/td[@class="number statistic game-minutes available"]')
    for i in 0..(minutes_odd.size-1)
      minutes.push(minutes_odd[i].text)
    end

    minutes_even = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="even"]/td[@class="number statistic game-minutes available"]')
    for i in 0..(minutes_even.size-1)
      minutes.push(minutes_even[i].text)
    end

    return minutes
  end

  def self.get_player_url(url_doc)
    url = []
    
    url_odd = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="odd"]/td[@class="name large-link"]/a/@href')
    for i in 0..(url_odd.size-1)
      url.push(url_odd[i].text)
    end

    url_even = url_doc.xpath('//div[@class="squad-container"]/table[@class="table squad sortable"]/tbody/tr[@class="even"]/td[@class="name large-link"]/a/@href')
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

end
  
