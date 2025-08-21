require "jwt"

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  SECRET_KEY = Rails.application.secret_key_base # safe place for JWT secret

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      payload = { user_id: user.id, exp: 24.hours.from_now.to_i } # token valid 24h

      token = JWT.encode(payload, SECRET_KEY, "HS256")

      render json: { message: "Login successful", user_id: user.id, token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged out." }, status: :ok
  end
end
