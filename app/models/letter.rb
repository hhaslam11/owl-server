class Letter < ApplicationRecord
  belongs_to :user_owl
  belongs_to :user, :foreign_key => 'sender_id'
  belongs_to :user, :optional => true, :foreign_key => 'receiver_id'
  belongs_to :country, :foreign_key => 'from_country_id'
  belongs_to :country, :foreign_key => 'to_country_id'

  after_initialize :init

  def init
    self.sent_date = Time.now if self.sent_date.nil?
  end 
end
