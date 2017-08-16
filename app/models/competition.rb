class Competition < ActiveRecord::Base
  # Use friendly id for slug creation
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Settings
  has_settings :mailchimp


  # Relations
  has_many :entries, inverse_of: :competition

  # Validations
  validates :name, presence: true
end
