class Country < ApplicationRecord
  has_many :seals
  has_many :letters
  has_and_belongs_to_many :languages
end
