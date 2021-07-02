class User < ApplicationRecord
  has_secure_password

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  validates :name, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP,
                   uniqueness: { case_sensitive: false }
end
