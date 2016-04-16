class API::V1::StoryController < ApiController
  include ApplicationHelper

  def create
    status = 200

    logger.info in_point(params['latitude'], params['longitude'])

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