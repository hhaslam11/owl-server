class Letter < ApplicationRecord
  belongs_to :user_owl
  belongs_to :user, :foreign_key => 'sender_id'
  belongs_to :user, :optional => true, :foreign_key => 'receiver_id'
  belongs_to :country, :foreign_key => 'from_country_id'
  belongs_to :country, :foreign_key => 'to_country_id'

  # after_initialize :init

  # def init
    
    
  #   #api for km
  #   #calculation of km * speed
  #   #get future delivery date
  #   #Time.now + 3600 (an hour forward)
  #   # Time.new(2015, 12, 8, 10, 19)
  #   #=> 2015-12-08 10:19:00 -0200
  
    
  #   self.delivery_date = country.id if self.delivery_date.nil? 
  #   #||= 0.0           #will set the default value only if it's nil
  #   end
end
