module Transfer
  require 'open-uri'
  require 'kconv'
  require 'nokogiri'

  def self.crawl(start_url)
    doc = Nokogiri::HTML(open(start_url, &:read))
    return doc
  end

  def self.get_player_doc(player_url)
    player_doc = []

    for i in 0..(player_url.size-1)
      _player_doc = self.crawl('http://www.transfermarkt.co.uk'+player_url[i])
      player_doc.push(_player_doc)
    end

    return player_doc
  end

  def self.get_player_minutes(doc)
    minutes = []

    minutes_odd = doc.xpath('//table[@class="items"]/tbody/tr[@class="odd"]/td[@class="rechts  "]')
    for i in 0..(minutes_odd.size-1)
      minutes.push(minutes_odd[i].text)
    end

    minutes_even = doc.xpath('//table[@class="items"]/tbody/tr[@class="even"]/td[@class="rechts  "]')
    for i in 0..(minutes_even.size-1)
      minutes.push(minutes_even[i].text)
    end

    return minutes
  end

  def self.get_team_doc(team_url)
    team_doc = []

    for i in 0..(team_url.size-1)
      _team_doc = self.crawl('http://www.transfermarkt.co.uk'+team_url[i])
      team_doc.push(_team_doc)
    end

    return team_doc
  end

  def self.get_player_age(player_doc)
    age = []
    th_td = {}

    for i in 0..(player_doc.size-1)
      th = player_doc[i].xpath('//div[@class="spielerdaten"]/table[@class="auflistung"]/tr/th')
      td = player_doc[i].xpath('//div[@class="spielerdaten"]/table[@class="auflistung"]/tr/td')

      for j in 0..(th.size-1)
        if th[j]
          th_td[th[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")] = td[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")
        end
      end
      
      age.push(th_td["Age:"])
    end

    return age
  end

  def self.get_player_position(player_doc)
    position = []
    th_td = {}

    for i in 0..(player_doc.size-1)
      th = player_doc[i].xpath('//div[@class="dataDaten"]/p/span[@class="dataItem"]')
      td = player_doc[i].xpath('//div[@class="dataDaten"]/p/span[@class="dataValue"]')

      for j in 0..(th.size-1)
        if th[j]
          th_td[th[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")] = td[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")
        end
      end
      
      position.push(th_td["Position:"].strip!)
    end

    return position
  end

  def self.get_player_height(player_doc)
    height = []
    th_td = {}

    for i in 0..(player_doc.size-1)
      th = player_doc[i].xpath('//div[@class="spielerdaten"]/table[@class="auflistung"]/tr/th')
      td = player_doc[i].xpath('//div[@class="spielerdaten"]/table[@class="auflistung"]/tr/td')

      for j in 0..(th.size-1)
        if th[j]
          th_td[th[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")] = td[j].text.gsub(/(\r\n|\r|\n|\f|\t)/,"")
        end
      end

      height.push(th_td["Height:"])
    end

    return height
  end

  def self.get_team_url(player_doc)
    team_url = []

    for i in 0..(player_doc.size-1)
      team_doc = player_doc[i].xpath('//div[@class="dataZusatzDaten"]/span[@class="hauptpunkt"]/a/@href')
      if team_doc then
        team_url.push(team_doc.text)
      elsif !team_doc then
        team_url.push(team_doc)
      end
    end

    return team_url
  end

  def self.get_player_team(player_doc)
    team = []

    for i in 0..(player_doc.size-1)
      team_name = player_doc[i].xpath('//div[@class="dataZusatzDaten"]/span[@class="hauptpunkt"]/a').text

      team.push(team_name)
    end

    return team
  end

  def self.get_player_url(url_doc)
    url = []

    url_odd = url_doc.xpath('//table[@class="items"]/tbody/tr[@class="odd"]/td/table[@class="inline-table"]/tr/td/div/span[@class="hide-for-small"]/a/@href')
    for i in 0..(url_odd.size-1)
      url.push(url_odd[i].text)
    end

    url_even = url_doc.xpath('//table[@class="items"]/tbody/tr[@class="even"]/td/table[@class="inline-table"]/tr/td/div/span[@class="hide-for-small"]/a/@href')
    for i in 0..(url_even.size-1)
      url.push(url_even[i].text)
    end

    return url
  end

  def self.get_player_name(player_doc)
    name = []

    for i in 0..(player_doc.size-1)
      _name = player_doc[i].xpath('//div[@class="dataBild"]/img/@title')
      name.push(_name.text)
    end

    return name
  end

  def self.get_player_picture(test_doc)
    name = []
    picture = []

    name_odd = test_doc.xpath('//table[@class="items"]/tbody/tr[@class="odd"]/td/table[@class="inline-table"]/tr/td/a/img/@title')

    for i in 0..(name_odd.size-1)
      name.push(name_odd[i].text.gsub(/(\s)/,"_"))
    end

    name_even = test_doc.xpath('//table[@class="items"]/tbody/tr[@class="even"]/td/table[@class="inline-table"]/tr/td/a/img/@title')

    for i in 0..(name_even.size-1)
      name.push(name_even[i].text.gsub(/(\s)/,"_"))
    end

    picture_odd = test_doc.xpath('//table[@class="items"]/tbody/tr[@class="odd"]/td/table[@class="inline-table"]/tr/td/a/img/@src')

    for i in 0..(picture_odd.size-1)
      picture.push(picture_odd[i].text)
    end

    picture_even = test_doc.xpath('//table[@class="items"]/tbody/tr[@class="even"]/td/table[@class="inline-table"]/tr/td/a/img/@src')

    for i in 0..(picture_even.size-1)
      picture.push(picture_even[i].text)
    end

    for i in 0..(name.size-1)

      fileName = name[i] + ".jpg"
      dirName = "/home/masa/soccer_test/player/"
      filePath = dirName + fileName

      open(filePath, 'wb') do |output|
        open(picture[i]) do |data|
          output.write(data.read)
        end
      end
    end
  end

  def self.picture(player_doc)
    picture = []

    for i in 0..(player_doc.size-1)
      _picture = player_doc[i].xpath('//div[@class="box-content"]/div[@class="headerfoto"]/img/@src')
      picture.push(_picture.text)
    end

    return picture
  end

  def self.get_team_national(team_doc)
    team_national = []

    for i in 0..(team_doc.size-1)
      _team_national = team_doc[i].xpath('//div[@class="flagge"]/a/img/@title')
      if _team_national then
        team_national.push(_team_national.text)
      elsif !_team_national then
        team_national.push(_team_national)
      end
    end

    return team_national
  end

  def self.get_team_division(team_doc)
    division = []

    for i in 0..(team_doc.size-1)
      _division = team_doc[i].xpath('//div[@class="box-personeninfos"]/div[@class="list"]/table[@class="profilheader"]/tr/td/a')[0]
      if _division then
        division.push(_division.text)
      elsif !_division then
        division.push(_division)
      end
    end

    return division
  end

end
