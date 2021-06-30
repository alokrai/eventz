class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP,
                   uniqueness: { case_sensitive: false }


end
