class Entry < ActiveRecord::Base
  # Constants
  EMAIL_REGEX = /\A[A-Z0-9._%a-z\-+]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,12}\z/

  # Relations
  belongs_to :competition

  # Callbacks
  before_validation :clean_email

  # Validations
  validates :competition, presence: { inverse_of: :entries }
  validates :email, presence: true
  validates :email, format: { with: EMAIL_REGEX, allow_blank: true, allow_nil: true }
  validates :name, presence: true, if: :requires_name
  validates :email, uniqueness: { scope: :competition, message: "has already entered this competition" }

  private
    def clean_email
      self.email = email.downcase.strip if email.present?
    end

    def requires_name
      competition.requires_entry_name?
    end
end
