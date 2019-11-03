class Postoffice::LettersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    country = Country.where('abbreviation = ?', letter_params[:country_code])[0]
    letter = Letter.where('to_country_id = ? AND receiver_id is null AND delivery_date <= ?', country.id, Time.current).order(:delivery_date)[0]

    if letter.nil?
      render json: { status: 'ERROR', data: "There are no messages at the moment!" }
    else
      letter.update!(letter_params.except("country_code"))
      letter.update!({pick_up_date: Time.current})
      if letter.save
        render json: { status: 'SUCCESS', data: letter }
      else
        render json: { status: 'ERROR', data: letter.errors }
      end
    end
  end

 private
 # country_id - current user's id (TO DO: maybe take in country code and convert to id)
 # receiver_id - current user's id
  def letter_params
    params.permit(:country_code, :receiver_id, :pick_up_date)
  end

end
