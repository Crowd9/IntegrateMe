class Entry < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%a-z\-+]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,12}\z/

  belongs_to :competition

  attr_accessor :api_key

  before_validation :clean_email

  validates_presence_of   :competition, inverse_of: :entries
  validates_presence_of   :email
  validates_format_of     :email, :with => EMAIL_REGEX, allow_blank: true, allow_nil: true
  validates_presence_of   :name, if: :requires_name
  validates_uniqueness_of :email, scope: :competition, message: "has already entered this competition"

  after_create  :subscribe_user
  # after_update  :edit_subscribed_user
  # after_destroy :unsubscribe_user

  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end

  private
    def clean_email
      self.email = email.downcase.strip if email.present?
    end

    def requires_name
      competition.requires_entry_name?
    end

    def subscribe_user
      SubscribeUserJob.perform_later(self, @api_key)
    end
end
