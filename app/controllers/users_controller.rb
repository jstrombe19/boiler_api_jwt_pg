class UsersController < ApplicationController
  before_action :is_user_verified?, only: [:profile]

  def create
    user = User.new(user_params)
    if user.save
      render json: user 
    else
      render status: 418
    end
  end
  
  def profile
  end

  private

  def user_params 
    params.require('user').permit([:username, :password])
  end

  def is_user_verified? (request)
    user = User.find(params[:id])

    if !user 
      render status: 401
    else
      
  end

end
