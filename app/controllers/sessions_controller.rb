require "securerandom"

class SessionsController < ApplicationController

  def new
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect_to "/", notice: "You are already logged on, #{@user.username}."
    else
      @user = User.new
    end
  end

  def create
    if params.has_key? :username
      if @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to "/", success: "You have logged on, #{@user.username}"
        end
      end
    else
      @user = User.find_or_create_by(gh_uid: auth['uid']) do |u|
        u.username = auth['info']['nickname']
          u.gh_email = auth['info']['email']
          u.password = SecureRandom.base64(12)
      end
      session[:user_id] = @user.id
      redirect_to "/", success: "You have been logged on, #{@user.username}."
    end
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
      redirect_to "/", notice: "You have successfully logged out"
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def current_user
    @user = User.find_by(id: session[user_id])
  end

  def logged_on
    unless current_user
      redirect_to "/"
    end
  end
end
