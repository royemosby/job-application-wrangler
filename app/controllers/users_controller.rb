class UsersController < ApplicationController
  before_action :logged_on
  before_action :set_user, :redirect_forbidden, only: %i[index show edit update destroy ]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def redirect_forbidden
    if session[:user_id] != params[:id].to_i
      respond_to do |format|
        format.html {redirect_to user_url(@user), notice: "You are not authorized to view or modify other users"}
        format.json {render :index, status: :forbidden}
      end
    end
  end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
