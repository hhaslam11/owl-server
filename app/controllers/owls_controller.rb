require_relative '../helpers/letters_helper'
class OwlsController < ApplicationController
  def index
    data = []
    user_owls = UserOwl.where('user_id = ?', params[:user_id])
    
    user_owls.each do |user_owl|
      # letters = Letter.where('user_owl_id = ?', user_owl.id)
      owl = Owl.where('id = ?', user_owl.owl_id)
      data.push({
        user_owls_id: user_owl.id,
        owl: owl,
        letters: LettersHelper.transform_letters('user_owl_id', user_owl.id)
      })
    end
    
    render json: { status: 'SUCCESS', data: data }
  end
end
