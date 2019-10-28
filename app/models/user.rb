class User < ApplicationRecord
  has_many :user_owls
  has_many :owls, :through :user_owls
  has_and_belongs_to_many :seals
end
