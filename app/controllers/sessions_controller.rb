require 'ipinfo'
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    access_token = "#{ENV['IPINFO_TOKEN']}"
    puts request.env['HTTP_X_FORWARDED_FOR']
    handler = IPinfo::create(access_token)
    
    #testing for a proxy
    details = handler.details(request.env['HTTP_X_FORWARDED_FOR'])
    
    if !details.respond_to?(:country)
      details = handler.details(request.remote_ip)
    end

    if !details.respond_to?(:country)
      render json: { status: 'ERROR', data: "#{request.remote_ip}/ #{request.env['HTTP_X_FORWARDED_FOR']} was not found in the database" }
    else
      render json: { status: 'SUCCESS', data: details.country}
    end
  end

  def show
    country = Country.where('abbreviation = ?', country_params[:country_code])[0]
    render json: { status: 'SUCCESS', data: country }
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

  private
  def country_params
    params.permit(:country_code)
  end

end
