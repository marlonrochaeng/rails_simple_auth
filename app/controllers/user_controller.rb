class UserController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [ :create ]
    before_action :authenticate_request, only: [ :get ]
  # before_action :verify_authenticity_token_for_get

  def create
    email = params[:email]
    pass = params[:password]
    existing_user = User.find_by(email: email)
    if existing_user
      render json: { error: "User already exists" }, status: :unprocessable_content
    else
      @user = User.new(email: email, password: pass)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
      end
    end
  end

  def get
    @users = User.all
    render json: { message: @users }, status: :ok
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def verify_authenticity_token_for_get
    return unless request.get?

    token = request.headers["X-CSRF-Token"] || params[:authenticity_token]
    unless valid_authenticity_token?(session, token)
      raise ActionController::InvalidAuthenticityToken
    end
  end


  def authenticate_request
    auth_header = request.headers["Authorization"]
    token = auth_header.split(" ").last if auth_header

    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: "HS256" })
      @current_user = User.find(decoded[0]["user_id"])
    rescue JWT::DecodeError
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
