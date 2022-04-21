class ApplicationController < ActionController::API
  before_action :authenticated?

  def encode_token(payload)
    JWT.encode(payload, ENV["JWT_SECRET"])
  end

  def decode_auth_header
    if auth_header = request.headers["Authorization"]
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV["JWT_SECRET"])
      rescue JWT::VerificationError
        nil
      end
    end
  end

  def current_user
    if token = decode_auth_header
      @user = User.find(token[0]['user_id'])
    end
  end

  def authenticated?
    unless !!current_user
      render json: {message: "Please log in", status: :unauthorized}
    end
  end
end
