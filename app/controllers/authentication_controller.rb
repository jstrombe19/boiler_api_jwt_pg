class AuthenticationController < ApplicationController

  def login
    @user = User.find_by(username: params[:username])

    if !@user 
      render status: 401
    else 
      if @user.authenticate(params[:password])
        secret_key = Rails.application.secrets.secret_key_base[0]
        token = JWT.encode({user_id: @user.id}, secret_key)

        render json: {token: token}
      else
        render status: 418
      end
    end
  end

end