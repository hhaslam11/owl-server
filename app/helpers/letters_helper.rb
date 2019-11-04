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
