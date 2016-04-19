class API::V1::StoryController < ApiController
  include ApplicationHelper

  def stories
    status = 200
    @location = Location.find_by_slug(params['slug'])
    @stories = Story.where(location_id: @location.id)

    @stories_response = @stories.map do |story|
      {
        id: story.id,
        story_id: story.story_id,
        location_id: story.location_id,
        elevation: story.elevation,
        under: story.under,
        latitude: story.latitude,
        longitude: story.longitude,
        photo_original: "http://10.34.65.25:3000/stories/#{story.story_id}_story.jpeg",
        photo_story: "http://10.34.65.25:3000/stories/#{story.story_id}_story.jpeg"
      }
    end

    @response = {
      meta: {
        code: status
      },
      data: {
        stories: @stories_response
      }
    }

    render json: @response, status: status
  end

  def create
    status = 200
    latitude = params['latitude']
    longitude = params['longitude']
    photo = params['photo']
    uuid_id = params['uuid_id']
    story_id = SecureRandom.hex

    @user = User.find_by_UUID(uuid_id)

    # SAVE BASE64 TO IMAGE
    jpeg_data = Base64.decode64(photo)
    File.open(Rails.root.join("public", "stories", "#{story_id}.jpeg"), 'wb') do |f|
      f.write jpeg_data
    end

    # GET ELEVATION INFO FROM GOOGLE
    get_elevation = HTTParty.get("https://maps.googleapis.com/maps/api/elevation/json?locations=#{latitude},#{longitude}&key=AIzaSyCj44N7XnQUWo0EgS2tkW9qTSqSl-lMNxM")
    data_elevation = JSON.parse(get_elevation.body)

    #DID WE GET THE INFO OR NOT
    if get_elevation.code == 200 && data_elevation['status'] == 'OK'
      elevation = data_elevation['results'][0]['elevation'].to_i * 3.2808.to_i

      image = MiniMagick::Image.new("public/stories/#{story_id}.jpeg")

      at_point = in_point(latitude, longitude)
      location_id = Location.find_by_slug(at_point).id

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

        logger.info elevation
        logger.info under

        image = image.composite(water) do |c|
          c.compose "Over"
          c.geometry water_scale(under)
        end
      end

      image = image.composite(badge) do |c|
        c.gravity 'SouthEast'
        c.compose "Over"
        c.geometry "+40+40"
      end

      image.write "public/stories/#{story_id}_story.jpeg"
      # Rails.root.join('public', 'stories', "#{story_id}_story.jpeg")

      create_story = Story.create(
        user_id: @user.id,
        story_id: story_id,
        location_id: location_id,
        elevation: elevation,
        under: under,
        latitude: latitude,
        longitude: longitude
      )

      @story_response = {
        story_id: story_id,
        location_id: location_id,
        elevation: elevation,
        under: under,
        latitude: latitude,
        longitude: longitude,
        photo: "http://192.168.1.119:3000/stories/#{story_id}_story.jpeg"
      }
    else

    end

    @response = {
      meta: {
        code: status
      },
      data: {
        story: @story_response
      }
    }

    render json: @response, status: status
  end

end