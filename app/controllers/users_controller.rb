class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    data = { id: user.id, email: user.email, username: user.username, avatar: user.avatar, join_date: user.join_date, last_login: user.last_login }
    render json: { status: 'SUCESS', data: data  }
  end

  def create
    user = User.new(user_params)
    userOwl = UserOwl.new(user_id: user.id, owl_id: 1)
    if user.save && userOwl.save
      render json: { status: 'SUCESS'}
    else
      errors = { user: user.errors, userOwl: userOwl.errors}
      render json: { status: 'ERROR', data: errors}
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :avatar)
  end
end
