class SessionsController < ApplicationController

  skip_before_action :authenticated?, only: %i[create]

  def create
    if params.has_key? :username
      @user = User.find_by(username: params[:username])
      if  @user && @user.authenticate(params[:password])
          @token = encode_token({user_id: @user.id})
          render json: {user: @user, jwt: @token}
      else
        render json: {message: "Invalid username or password"}, status: :unauthorized
      end
    end
  end

  #TODO: determine logout mechanism
  def destroy
  end

end
