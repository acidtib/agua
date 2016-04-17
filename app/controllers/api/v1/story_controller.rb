class API::V1::StoryController < ApiController
  include ApplicationHelper

  def create
    status = 200
    latitude = params['latitude']
    longitude = params['longitude']
    address_components = params['address_components']
    photo = params['photo']
    user_id = params['user_id']
    story_id = SecureRandom.hex

    get_elevation = HTTParty.get("https://maps.googleapis.com/maps/api/elevation/json?locations=#{latitude},#{longitude}&key=AIzaSyCj44N7XnQUWo0EgS2tkW9qTSqSl-lMNxM")
    data_elevation = JSON.parse(get_elevation.body)

    if get_elevation.code == 200 && data_elevation['status'] == 'OK'
      elevation = data_elevation['results'][0]['elevation'].to_i * 3.2808.to_i

      image = MiniMagick::Image.new("/Users/arubinofaux/Code/miami_under/public/Ms6GBxwz4Jm8qyx.png")

      at_point = in_point(latitude, longitude)

      if elevation > 10
        under = 'safe'
        badge = MiniMagick::Image.new(img_url('badges/safezone.png'))
      else
        under = 10 - elevation
        water = MiniMagick::Image.new(img_url('water.png'))

        logger.info at_point

        if at_point == 'nada'
          badge = MiniMagick::Image.new(img_url("badges/default/#{under}.png"))
        else
          badge = MiniMagick::Image.new(img_url("badges/#{at_point}/#{under}.png"))
        end

        image = image.composite(water) do |c|
          c.compose "Over"
          c.geometry "#{water_scale(under)}"
        end
      end

      logger.info elevation
      logger.info under

      image = image.composite(badge) do |c|
        c.gravity 'SouthEast'
        c.compose "Over"
        c.geometry "+40+40"
      end

      image.write "/Users/arubinofaux/Downloads/test.png"

    else
      # COULD NOT GET ELEVATION DATA
    end

    @response = {
      meta: {
        code: status
      },
      data: {
        user: '@user_response'
      }
    }

    render json: @response, status: status
  end

end