class Postoffice::LettersController < ApplicationController
  
  # If we want to display all letters with countries, where the user can pick a country (update needs to be changed to accept an id)
  # def index
  #   received_letters = Letter.where('to_country_id = ? AND receiver_id = ?', params[:country_id], null)
  #   render json: { status: 'SUCCESS', data: received_letters }
  # end

  def update
    letter = Letter.where('to_country_id = ? AND receiver_id = ? AND delivery_date <= ?', params[:country_id], null, Time.now).order(:delivery_date)[0]
    # letter.receiver_id = letter_params
    # if letter.save
      render json: { status: 'SUCCESS', data: letter }
    # else
      render json: { status: 'ERROR', data: letter.errors }
    # end
  end

 private
  def letter_params
    params.permit(:sender_id, :from_country_id, :to_country_id, :user_owl_id, :content, :sent_date)
  end

end
