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

end
