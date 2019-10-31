class LettersController < ApplicationController
  def index
    sent_letters = Letter.where('sender_id = ?', params[:user_id])
    received_letters = Letter.where('receiver_id = ?', params[:user_id])
    data = { sent_letters: sent_letters, received_letters: received_letters }
    render json: { status: 'SUCCESS', data: data }
  end

  def create
    letter = Letter.new(letter_params)

    if letter.save
      render json: { status: 'SUCCESS' }
    else
      render json: { status: 'ERROR', data: letter.errors }
    end
  end

  # not using user id at all - authentication?
  def show
    letter = Letter.where('id = ?', params[:id])
    render json: { status: 'SUCCESS', data: letter }
  end

  private
  def letter_params
    params.require(:letter).permit(:sender_id, :from_country_id, :to_country_id, :user_owl_id, :content, :sent_date)
  end
end
