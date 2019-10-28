class Owl < ApplicationRecord
  has_many :user_owls
  has_many :users, :through :user_owls
end
