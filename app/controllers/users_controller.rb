class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    user = User.find(params[:id])
    data = { id: user.id, email: user.email, username: user.username, avatar: user.avatar, join_date: user.join_date, last_login: user.last_login }
    render json: { status: 'SUCCESS', data: data  }
  end

  def create
    user = User.new(user_params)
    if user.save
      userOwl = UserOwl.new(user_id: user.id, owl_id: 1)
      
      if userOwl.save
        data = { id: user.id }
        render json: { status: 'SUCCESS', data: data }
      else
        render json: { status: 'ERROR', data: userOwl.errors}
      end
      
    else
      render json: { status: 'ERROR', data: user.errors}
    end
  end

  private
  def user_params
    params.permit(:email, :username, :password, :password_confirmation, :avatar)
  end

end
