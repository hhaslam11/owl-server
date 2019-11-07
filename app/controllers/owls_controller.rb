require_relative '../helpers/letters_helper'
class OwlsController < ApplicationController
  def index
    data = []
    user_owls = UserOwl.where('user_id = ?', params[:user_id])
    
    user_owls.each do |user_owl|
      letters = Letter.where('user_owl_id = ?', user_owl.id)

      return letters.map { |letter|

        if Country.exists?(id: letter.to_country_id)
          to_country = Country.find(letter.to_country_id)

          receiving_country = {
            id: to_country.id,
            name: to_country.name,
            abbreviation: to_country.abbreviation,
          }
        end

        if Country.exists?(id: letter.from_country_id)
          from_country = Country.find(letter.from_country_id)

          sending_country = {
            id: from_country.id,
            name: from_country.name,
            abbreviation: from_country.abbreviation,
          }
        end

        {
          id: letter.id,
          sending_country: sending_country,
          receiving_country: receiving_country,
          sender: letter.sender_id,
          receiver: letter.receiver_id,
          user_owl_id: letter.user_owl_id,
          content: letter.content,
          sent_date: letter.sent_date,
          delivery_date: letter.delivery_date,
          pick_up_date: letter.pick_up_date,
          read: self.is_read(letter.pick_up_date)
        }

      }

      owl = Owl.where('id = ?', user_owl.owl_id)
      data.push({
        user_owls_id: user_owl.id,
        owl: owl,
        letters: letters
      })
    end
    
    render json: { status: 'SUCCESS', data: data }
  end
end
