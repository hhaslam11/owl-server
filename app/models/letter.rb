class Letter < ApplicationRecord
  belongs_to :country
  belongs_to :user_owl
  belongs_to :user, :foreign_key => 'sender_id', :foreign_key => 'receiver_id'
end
