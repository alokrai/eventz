class Registration < ApplicationRecord
  belongs_to :event

  validates :name, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  HOW_HEARD_OPTIONS = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ].freeze

  validates :how_heard,
            inclusion: { in: HOW_HEARD_OPTIONS }

end
