class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  add_flash_types :success

  def current_user
    @user = User.find_by(id: session[:user_id])
  end

  def logged_on
    unless current_user
      redirect_to "/", alert: "You have to be logged in to access that page."
    end
  end
end
