class OwlsController < ApplicationController
  def index
    data = []
    user_owls = UserOwl.where('user_id = ?', params[:user_id])
    
    user_owls.each do |user_owl|
      letters = Letter.where('user_owl_id = ?', user_owl.id)
      owl = Owl.where('id = ?', user_owl.owl_id)
      data.push({
        user_owls_id: user_owl.id,
        owl: owl,
        letters: letters
      })
    end
    
    render json: { status: 'SUCESS', data: data }
  end
end
