class LettersController < ApplicationController
  def index
    sent_letters = Letter.where('sender_id = ?', params[:user_id])
    received_letters = Letter.where('receiver_id = ?', params[:user_id])
    data = { sent_letters: sent_letters, received_letters: received_letters }
    render json: { status: 'SUCESS', data: data }
  end

  def create
    country = Country.where('abbreviation = ?', country_params)
    letter = Letter.new(letter_params, sender_id: params[:user_id], country_id: country.id)

    if letter.save
      render json: { status: 'SUCESS'}
    else
      render json: { status: 'ERROR', data: letter.errors}
    end
  end

  # not using user id at all - authentication?
  def show
    letter = Letter.where('id = ?', params[:id])
    render json: { status: 'SUCESS', data: letter }
  end

  private
  def letter_params
    params.require(:letter).permit(:user_owl_id, :content, :sent_date)
  end

  def country_params
    params.permit(:country_code)
  end
end
