class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: { status: 'SUCESS', data: user }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 'SUCESS', data: user}
    else
      render json: { status: 'ERROR', data: user.errors}
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :avatar)
  end
end
