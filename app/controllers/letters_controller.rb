require_relative '../helpers/letters_helper'
class LettersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    data = { sent_letters: LettersHelper.transform_letters('sender_id', params[:user_id]),
              received_letters: LettersHelper.transform_letters('receiver_id', params[:user_id])
            }
    render json: { status: 'SUCCESS', data: data }
  end

  def create
    create_params = letter_params.except("read", "user_id", "id", "from_country_code", "to_country_code", "reply", "letter_replied_to")
    
    
    from_country = Country.where('abbreviation = ?', letter_params[:from_country_code])[0]
    to_country = Country.where('abbreviation = ?', letter_params[:to_country_code])[0]

    create_params[:sender_id] = letter_params[:user_id]
    create_params[:from_country_id] = from_country.id
    

    if create_params[:user_owl_id]
      user_owl = UserOwl.where('user_id = ? AND owl_id = ?', letter_params[:user_id], create_params[:user_owl_id])[0]
      owl = Owl.find(user_owl.owl_id)
    else
      user_owl = UserOwl.where('user_id = ? AND owl_id = ?', letter_params[:user_id], 1)[0]
      owl = Owl.find(user_owl.owl_id)
      create_params[:user_owl_id] = user_owl.id
    end

    # if !create_params[:sent_date]
    #   create_params[:sent_date] = Time.current
    # end

    create_params[:delivery_date] = LettersHelper.deliverySetting(from_country, to_country, owl)

    if letter_params[:reply]
      letter_replied_to = Letter.find(letter_params[:letter_replied_to])
      create_params[:receiver_id] = letter_replied_to.sender_id
    else
      create_params[:to_country_id] = to_country.id
    end

    letter = Letter.new(create_params)

    if letter.save
      render json: { status: 'SUCCESS', data: letter }
    else
      render json: { status: 'ERROR', data: letter.errors }
    end
  end

  # not using user id at all - authentication?
  def show
    render json: { status: 'SUCCESS', data: LettersHelper.transform_letters('id', params[:user_id]) }
  end

  def update
    letter = Letter.find(params[:id])
    letter.update!(letter_params.except("read", "user_id", "id", "reply", "letter_replied_to"))

    if letter_params[:read]
      letter.update!({pick_up_date: Time.current})
    end

    render json: { status: 'SUCCESS', data: LettersHelper.transform_letters('id', params[:id]) }
  end

  private
  def letter_params
    params.permit(:user_id, :id, :from_country_code, :to_country_code, :user_owl_id, :content, :sent_date, :read, :reply, :letter_replied_to)
  end
  
end
