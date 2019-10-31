class Letter < ApplicationRecord
  belongs_to :user_owl
  belongs_to :user, :foreign_key => 'sender_id'
  belongs_to :user, :foreign_key => 'receiver_id'
  belongs_to :country, :foreign_key => 'from_country_id'
  belongs_to :country, :foreign_key => 'to_country_id'
end
