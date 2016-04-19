class API::V1::UserController < ApiController

  def create
    status = 200
    if @user = User.find_by_UUID(params['UUID'])
      @user_response = {
        user_id: @user.id,
        UUID: @user.UUID
      }
    else
      @user_create = User.create(
        UUID: params['UUID']
      )

      @user_response = {
        user_id: @user_create.id,
        UUID: @user_create.UUID
      }
    end

    @response = {
      meta: {
        code: status
      },
      data: {
        user: @user_response
      }
    }

    render json: @response, status: status
  end

end