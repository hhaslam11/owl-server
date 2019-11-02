require 'ffaker'
class User < ApplicationRecord
  has_secure_password

  has_many :letters
  has_many :user_owls
  has_many :owls, through: :user_owls
  has_and_belongs_to_many :seals

  validates :email, presence: true,
                    format: { with: /@/, message: "must be valid" },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  attribute :avatar, default: FFaker::Avatar.image

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
end
