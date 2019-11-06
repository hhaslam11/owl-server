module LettersHelper

  def LettersHelper.distance(lat1, lon1, lat2, lon2)
    r = 6371e3; # metres
    φ1 = lat1 * Math::PI/180
    φ2 = lat2 * Math::PI/180
    Δφ = (lat2-lat1) * Math::PI/180
    Δλ = (lon2-lon1) * Math::PI/180

    a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
        Math.cos(φ1) * Math.cos(φ2) *
        Math.sin(Δλ/2) * Math.sin(Δλ/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    d = (r * c).round
  end

  def LettersHelper.deliverySetting(country1, country2, owl)
    if !country1.lat || !country1.lon || !country2.lat || !country2.lon
      time = 86400
    else
      time = self.distance(country1.lat, country1.lon, country2.lat, country2.lon) / (1000 * owl.speed) * 3600
    end
    Time.current + time
  end

  def LettersHelper.is_read(pick_up_date)
    if pick_up_date
      return true
    end
    false
  end

  def LettersHelper.data_structure(user_id)
  
    # letters = (letters1 << letters2).flatten!
    result = Hash.new
    #IF LETTER IS SENT BY CURRENT USER
    letters1 = Letter.where("sender_id = ?", user_id)
    letters1.each do |letter|

      if letter.to_country_id
        country = Country.find(letter.to_country_id)
      end
      
      #IF LETTER HAS BEEN PICKED UP
      if letter.receiver_id
        user = User.find(letter.receiver_id)
        
        user_data = {
          user_id: user.id,
          username: user.username,
          avatar: user.avatar,
          country: country,
          letters: Array.new
        }

        if !result[user.id]
          result[user.id] = user_data
        end
        
      #IF LETTER HAS NOT BEEN PICKED UP
      else
        
        user_data = {
          user_id: nil,
          username: nil,
          avatar: nil,
          country: country,
          letters: Array.new
        }
        if !result[letter.sent_date]
          result[letter.sent_date] = user_data
        end
      end
    end

    letters1.each do |letter|
      #IF LETTER HAS BEEN PICKED UP
      letter_data = {
          letter_id: letter.id,
          user_owl_id: letter.user_owl_id,
          content: letter.content,
          sent_date: letter.sent_date,
          delivery_date: letter.delivery_date,
          pick_up_date: letter.pick_up_date,
          read: self.is_read(letter.pick_up_date),
          sent_by_current_user: true,
          sort_time: letter.sent_date,
          sender: letter.sender_id
        }

      if letter.receiver_id

        (result[letter.receiver_id][:letters] << letter_data).flatten!

      else

        (result[letter.sent_date][:letters] << letter_data).flatten!

      end
    end
      
    #IF LETTER IS SENT BY SOMEONE ELSE
    letters2 = Letter.where("receiver_id = ? AND delivery_date is not null AND delivery_date <= ?", user_id, Time.current)
    letters2.each do |letter|

      if letter.from_country_id
      country = Country.find(letter.from_country_id)
      end

      user = User.find(letter.sender_id)
      user_data = {
          user_id: user.id,
          username: user.username,
          avatar: user.avatar,
          country: country,
          letters: Array.new
        }

      if !result[user.id]
        result[user.id] = user_data
      end
    end

    letters2.each do |letter|
      letter_data = {
          letter_id: letter.id,
          user_owl_id: letter.user_owl_id,
          content: letter.content,
          sent_date: letter.sent_date,
          delivery_date: letter.delivery_date,
          pick_up_date: letter.pick_up_date,
          read: self.is_read(letter.pick_up_date),
          sent_by_current_user: false,
          sort_time: letter.delivery_date,
          sender: letter.sender_id
        }

        (result[letter.sender_id][:letters] << letter_data).flatten!
    end

    #sorting letters arrays
    result.each do |user_id, user_object|
      
      user_object[:letters].sort_by {|letter| 
      
      letter[:sort_time]
      
    }
    end

    result.each do |userid, user_object|
      #if it's sent by user, but not picked up
 
      puts user_object[:letters].last[:sender].to_s == user_id
      if user_object[:letters].last[:sender].to_s == user_id
        user_object[:sort_time] = user_object[:letters].last[:sent_date]
        puts user_object[:letters].last[:sent_date]
        puts "....."
      else
        user_object[:sort_time] = user_object[:letters].last[:delivery_date]
        puts user_object[:letters].last[:delivery_date]
        puts "-----"
      end
    end

    #sorting entire object
    result.sort_by do |k, v| 
      v[:sort_time] ? v[:sort_time] : 0
    end

    final_result = Array.new

    result.each do |arr_of_user_keys_and_objects|
      (final_result << arr_of_user_keys_and_objects[1]).flatten!
    end

    return final_result
  end



  


  def LettersHelper.transform_letters(id, param)
    letters = Letter.where("#{id} = ?", param)
    return letters.map { |letter|

      if Country.exists?(id: letter.from_country_id)
        from_country = Country.find(letter.from_country_id)

        sending_country = {
          id: from_country.id,
          name: from_country.name,
          abbreviation: from_country.abbreviation,
          timezone: from_country.timezone,
          flag_image: from_country.flag_image,
          languages: from_country.languages
        }
      end

      if Country.exists?(id: letter.to_country_id)
        to_country = Country.find(letter.to_country_id)

        receiving_country = {
          id: to_country.id,
          name: to_country.name,
          abbreviation: to_country.abbreviation,
          timezone: to_country.timezone,
          flag_image: to_country.flag_image,
          languages: to_country.languages
        }
      end

      if User.exists?(id: letter.receiver_id)
        to_user = User.find(letter.receiver_id)

        receiver = {
        id: to_user.id,
        email: to_user.email,
        username: to_user.username,
        avatar: to_user.avatar,
        country: receiving_country
      }
      end

      if User.exists?(id: letter.sender_id)
        from_user = User.find(letter.sender_id)
      
        sender = {
          id: from_user.id,
          email: from_user.email,
          username: from_user.username,
          avatar: from_user.avatar,
          country: sending_country
        }
      end

      {
        id: letter.id,
        sender: sender,
        receiver: receiver,
        user_owl_id: letter.user_owl_id,
        content: letter.content,
        sent_date: letter.sent_date,
        delivery_date: letter.delivery_date,
        pick_up_date: letter.pick_up_date,
        read: self.is_read(letter.pick_up_date)
      }
    }
  end

end