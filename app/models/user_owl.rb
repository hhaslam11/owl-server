class UserOwl < ApplicationRecord
  belongs_to :user
  belongs_to :owl
  has_many :letters

  validates :user_id, presence: true 
  validates :owl_id, presence: true 
end
