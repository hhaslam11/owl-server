class Country < ApplicationRecord
  has_many :seals
  has_many :letters
end
