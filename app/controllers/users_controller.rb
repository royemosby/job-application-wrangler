class UsersController < ApplicationController
  skip_before_action :authenticated?, only: %i[create]

  def show
    if current_user === User.find(params[:id])
      render  json: @user
    else
      render json: {message: "You are not allowed to view other users"}, status: :forbidden
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({user_id: @user.id})
      render json: {user: @user, jwt: @token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
      debugger
      if @user.update(user_params)
        render json: @user, status: :ok, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  #TODO: contruct confirmation flow for users that have existing jobs/contacts
  def destroy
    @user.destroy
    render json: {message: "User was successfully destroyed."}, status: :no_content
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
