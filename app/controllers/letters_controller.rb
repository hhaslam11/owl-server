class LettersController < ApplicationController
  def index
    # letters = Letter.where(`#{id} = ?`, params[:user_id])
    data = { sent_letters: letters('sender_id'), received_letters: letters('receiver_id') }
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

  private
  def letters (id)
    letters = Letter.where("#{id} = ?", params[:user_id])
    pp letters
    return letters.map { |letter|
      puts "test"
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
        receiver = User.find(letter.receiver_id)
      end
      
      {
        id: letter.id,
        sender_id: letter.sender_id,
        sending_country: sending_country,
        receiving_country: receiving_country,
        receiver: receiver, content: letter.content,
        sent_date: letter.sent_date,
        delivery_date: letter.delivery_date,
        pick_up_date: letter.pick_up_date
      }
    }
  end
end
