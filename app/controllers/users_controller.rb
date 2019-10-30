class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: { status: 'SUCESS', data: { user.email, user.username, user.avatar } }
  end

  def create
    user = User.new(user_params)
    userOwl = UserOwl.new(user_id: user.id, owl_id: 1)
    if user.save
      render json: { status: 'SUCESS'}
    else
      render json: { status: 'ERROR', data: user.errors}
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :avatar)
  end
end
