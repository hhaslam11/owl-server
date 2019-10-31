class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      render json: { status: 'SUCCESS', data: { id: user.id }}
    else
      render json: { status: 'ERROR', data: "Error logging in, please check your details"}
    end
  end

  # private
  # def login_params
  #   params.require(:user).permit(:email, :password)
  # end

end
