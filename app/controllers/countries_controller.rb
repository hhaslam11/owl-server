class CountriesController < ApplicationController

  def index
    received_letters = Letter.where('to_country_id = ?', params[:country_id])
    render json: { status: 'SUCCESS', data: received_letters }
  end

  def show
    letter = Letter.where('to_country_id = ? AND id = ?'params[:country_id] , params[:id])
    render json: { status: 'SUCCESS', data: letter }
  end

  def update
    letter = Letter.new(letter_params)

    if letter.save
      render json: { status: 'SUCCESS' }
    else
      render json: { status: 'ERROR', data: letter.errors }
    end
  end

 private
  def letter_params
    params.require(:letter).permit(:sender_id, :from_country_id, :to_country_id, :user_owl_id, :content, :sent_date)
  end

end
