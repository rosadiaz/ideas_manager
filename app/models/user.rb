class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: true


  before_save :titleize_name
  def titleize_name
    self.first_name = self.first_name.titleize if self.first_name
    self.last_name = self.last_name.titleize if self.last_name
  end
end
