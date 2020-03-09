class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: user 
    else
      render status: 418
    end
  end
  
  def profile
    is_user_authorized?(request)
    render json: @user 
  end
  
  def update
    is_user_authorized?(request)
    @user.update(user_params)
    render json: @user 
  end
  
  def destroy 
    is_user_authorized?(request)
    @user.destroy 
  end

  private

  def user_params 
    params.require('user').permit([:username, :password])
  end

  def is_user_authorized?(request)
    authorization_header = request.headers[:authorization]
    if !authorization_header 
      render status: 401
    else
      token = authorization_header.split(" ")[1]
      secret_key = Rails.application.secrets.secret_key_base[0]
      decoded_token = JWT.decode(token, secret_key)
      @user = User.find(decoded_token[0]["user_id"])
    end
    @user
  end

end


 # before_action only: [:profile, :update, :destroy] do 
  #   is_user_authorized?(request)
  # end