# require 'IPinfo'
load('/home/vagrant/.rvm/gems/ruby-2.3.5/gems/IPinfo-0.1.2')
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    
    handler = IPinfo::create()
    details = handler.details(request.remote_ip)
    country = details.country
    
    #TO DO: request.env['HTTP_X_FORWARDED_FOR']

    if details.nil?
      render json: { status: 'ERROR', data: "#{request.remote_ip} was not found in the database" }

    else
      country = Country.where('abbreviation = ?', details.country)
      render json: { status: 'SUCCESS', data: country}
    end
  end

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
