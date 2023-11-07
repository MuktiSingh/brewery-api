# Model class User
class User < ApplicationRecord
  ### CONSTANTS ###

  ROLES = {
    user: 0,
    admin: 1
  }

  ### ASSOCIATIONS ###

  has_one :address, as: :addressable, dependent: :destroy

  ### VALIDATIONS ###

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, email: true

  ### CALLBACKS ###
  before_create :set_identifer

  ### ENUMS ###
  enum role: ROLES

  has_secure_password

  def address_destroyable?
    true
  end

  private def set_identifer
    self.identifier = RandomTokenGenerator.new('User', 'identifier').generate_token
  end
end
