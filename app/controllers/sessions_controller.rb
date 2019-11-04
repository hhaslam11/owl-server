require 'ipinfo'
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    access_token = "#{ENV['IPINFO_TOKEN']}"
    puts request.env['HTTP_X_FORWARDED_FOR']
    handler = IPinfo::create(access_token)
    
    details = handler.details(request.remote_ip)
    
    #testing for a proxy
    if !details.respond_to?(:country)
      details = handler.details(request.env['HTTP_X_FORWARDED_FOR'])
    end

    if !details.respond_to?(:country)
      render json: { status: 'ERROR', data: "#{request.remote_ip} was not found in the database" }
    else
      country = Country.where('abbreviation = ?', details.country)
      render json: { status: 'SUCCESS', data: country}
    end
  end

  def create
    if user = User.authenticate_with_credentials(login_params[:email], login_params[:password])
      render json: { status: 'SUCCESS', data: { id: user.id }}
    else
      render json: { status: 'ERROR', data: "Error logging in, please check your details"}
    end
  end

  private
  def login_params
    params.permit(:email, :password)
  end

end
