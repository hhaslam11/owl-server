class OwlsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user_owls = UserOwl.where('user_id = ?', params[:user_id])
    letter = Letter.where('user_owl_id = ?', user_owl.id)
    # render json: { status: 'SUCESS', data: owl }
  end
end
