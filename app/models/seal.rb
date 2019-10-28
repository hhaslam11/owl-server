class Seal < ApplicationRecord
  belongs_to :country
  has_and_belongs_to_many :users
end
