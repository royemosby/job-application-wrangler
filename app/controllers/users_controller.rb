class UsersController < ApplicationController
  skip_before_action :authenticated?, only: %i[create]

  def index
    render json: {message: "You are not allowed to view other users"}, status: :forbidden
  end

  def show
    if current_user === User.find(params[:id])
      render  json: UserSerializer.new(@user)
    else
      render json: {message: "You are not allowed to view other users"}, status: :forbidden
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: @token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
      if @user.update(user_params)
        render json: UserSerializer.new(@user), status: :ok, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  #TODO: contruct confirmation flow for users that have existing jobs/contacts
  def destroy
    if current_user === User.find(params[:id])
      if @user.destroy
        render json: {message: "User was successfully destroyed."}, status: :no_content
      else
        render json: {message: "There are still jobs associated with this user."}, status: :locked
      end
    else
      if User.find(params[:id])
        render json: {message: "You are not allowed to delete other users"}, status: :forbidden
      else
        render json: {message: "not found"}, status: :not_found
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
