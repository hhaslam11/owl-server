class LettersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    data = { sent_letters: transform_letters('sender_id', params[:user_id]), received_letters: transform_letters('receiver_id', params[:user_id]) }
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
    render json: { status: 'SUCCESS', data: transform_letters('id', params[:user_id]) }
  end

  def update
    letter = Letter.find(params[:id])
    letter.update!(letter_params.except("read", "user_id", "id"))

    if letter_params[:read]
      letter.update!({pick_up_date: Time.now})
    end

    render json: { status: 'SUCCESS', data: transform_letters('id', params[:id]) }
  end

  private
  def letter_params
    params.permit(:user_id, :id, :sender_id, :from_country_id, :to_country_id, :user_owl_id, :receiver_id, :content, :sent_date, :delivery_date, :pick_up_date, :read)
  end

  private
  def is_read(pick_up_date)
    if pick_up_date
      return true
    end
    false
  end

  private
  def transform_letters(id, param)
    letters = Letter.where("#{id} = ?", param)
    return letters.map { |letter|
      from_country = Country.find(letter.from_country_id)
      to_country = Country.find(letter.to_country_id)

      sending_country = {
        id: from_country.id,
        name: from_country.name,
        abbreviation: from_country.abbreviation,
        timezone: from_country.timezone,
        flag_image: from_country.flag_image,
        languages: from_country.languages
      }

      receiving_country = {
        id: to_country.id,
        name: to_country.name,
        abbreviation: to_country.abbreviation,
        timezone: to_country.timezone,
        flag_image: to_country.flag_image,
        languages: to_country.languages
      }

      if User.exists?(id: letter.receiver_id)
        to_user = User.find(letter.receiver_id)

        receiver = {
        id: to_user.id,
        email: to_user.email,
        username: to_user.username,
        avatar: to_user.avatar,
        country: receiving_country
      }
      end

      if User.exists?(id: letter.sender_id)
        from_user = User.find(letter.sender_id)
      
        sender = {
          id: from_user.id,
          email: from_user.email,
          username: from_user.username,
          avatar: from_user.avatar,
          country: sending_country
        }
      end

      {
        id: letter.id,
        sender: sender,
        receiver: receiver,
        content: letter.content,
        sent_date: letter.sent_date,
        delivery_date: letter.delivery_date,
        pick_up_date: letter.pick_up_date,
        read: is_read(letter.pick_up_date)
      }
    }
  end
end
