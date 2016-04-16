class API::V1::StoryController < ApiController
  include ApplicationHelper

  def create
    status = 200
    latitude = params['latitude']
    longitude = params['longitude']
    address_components = params['address_components']
    photo = params['photo']
    user_id = params['user_id']

    get_elevation = HTTParty.get("https://maps.googleapis.com/maps/api/elevation/json?locations=#{latitude},#{longitude}&key=AIzaSyCj44N7XnQUWo0EgS2tkW9qTSqSl-lMNxM")
    data_elevation = JSON.parse(get_elevation.body)

    if get_elevation.code == 200 && data_elevation['status'] == 'OK'
      elevation = data_elevation['results'][0]['elevation'].to_i * 3.2808.to_i

      if elevation > 10
        under = 'safe'
      else
        under = 10 - elevation
      end

    else
      # COULD NOT GET ELEVATION DATA
    end

    logger.info in_point(latitude, longitude)

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