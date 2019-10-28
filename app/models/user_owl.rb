class UserOwl < ApplicationRecord
  belongs_to :user
  belongs_to :owl
  has_many :letters
end
