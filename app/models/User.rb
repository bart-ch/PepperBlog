class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  # before_save { self.email = email.downcase }
  # Popracowac nad magic numbers
  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3, maximum: 25 }
  validates :email, presence: true,
                    length: { maximum: 105 },
                    uniqueness: { case_sensitivity: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
end
