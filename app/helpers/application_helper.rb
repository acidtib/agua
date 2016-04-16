module ApplicationHelper
  def in_point(lat, long)
    wynwood = Geokit::Polygon.new([
      Geokit::LatLng.new(25.812246, -80.206180),
      Geokit::LatLng.new(25.811380, -80.200496),
      Geokit::LatLng.new(25.811297, -80.191008),
      Geokit::LatLng.new(25.795286, -80.193942),
      Geokit::LatLng.new(25.795121, -80.200542),
      Geokit::LatLng.new(25.796895, -80.205538)
    ])

    downtown = Geokit::Polygon.new([
      Geokit::LatLng.new(25.792011, -80.185416),
      Geokit::LatLng.new(25.777723, -80.182812),
      Geokit::LatLng.new(25.771706, -80.184777),
      Geokit::LatLng.new(25.770069, -80.189641),
      Geokit::LatLng.new(25.770512, -80.192588),
      Geokit::LatLng.new(25.769026, -80.195374),
      Geokit::LatLng.new(25.769253, -80.197849),
      Geokit::LatLng.new(25.771300, -80.199667),
      Geokit::LatLng.new(25.774484, -80.201283),
      Geokit::LatLng.new(25.777122, -80.203960),
      Geokit::LatLng.new(25.778168, -80.206587),
      Geokit::LatLng.new(25.778805, -80.195879),
      Geokit::LatLng.new(25.788128, -80.196586),
      Geokit::LatLng.new(25.792675, -80.195121)
    ])

    brickell = Geokit::Polygon.new([
      Geokit::LatLng.new(25.770108, -80.199346),
      Geokit::LatLng.new(25.768794, -80.197716),
      Geokit::LatLng.new(25.768755, -80.194754),
      Geokit::LatLng.new(25.770108, -80.192437),
      Geokit::LatLng.new(25.769799, -80.188703),
      Geokit::LatLng.new(25.769683, -80.182438),
      Geokit::LatLng.new(25.763576, -80.184326),
      Geokit::LatLng.new(25.763808, -80.188274),
      Geokit::LatLng.new(25.756039, -80.189175),
      Geokit::LatLng.new(25.748037, -80.201879),
      Geokit::LatLng.new(25.752582, -80.205754),
      Geokit::LatLng.new(25.756883, -80.200077),
      Geokit::LatLng.new(25.766863, -80.200438)
    ])

    miamibeach = Geokit::Polygon.new([
      Geokit::LatLng.new(25.872735, -80.117554),
      Geokit::LatLng.new(25.751790, -80.119213),
      Geokit::LatLng.new(25.755205, -80.141723),
      Geokit::LatLng.new(25.764167, -80.151675),
      Geokit::LatLng.new(25.766942, -80.142671),
      Geokit::LatLng.new(25.778891, -80.170394),
      Geokit::LatLng.new(25.788278, -80.166129),
      Geokit::LatLng.new(25.801932, -80.165418),
      Geokit::LatLng.new(25.831794, -80.157836),
      Geokit::LatLng.new(25.847148, -80.141723),
      Geokit::LatLng.new(25.857597, -80.149305),
      Geokit::LatLng.new(25.871455, -80.141723)
    ])

    designdistrict = Geokit::Polygon.new([
      Geokit::LatLng.new(25.825162, -80.200044),
      Geokit::LatLng.new(25.825487, -80.187152),
      Geokit::LatLng.new(25.811467, -80.190452),
      Geokit::LatLng.new(25.811514, -80.199528)
    ])

    point = Geokit::LatLng.new(lat, long)

    if wynwood.contains?(point)
      return 'wynwood'
    end

    if downtown.contains?(point)
      return 'downtown'
    end

    if brickell.contains?(point)
      return 'brickell'
    end

    if miamibeach.contains?(point)
      return 'miamibeach'
    end

    if designdistrict.contains?(point)
      return 'designdistrict'
    end

    return 'nada'
  end
end
