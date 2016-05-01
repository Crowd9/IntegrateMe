class Campaign < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%a-z\-+]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,12}\z/

  belongs_to :user, inverse_of: :campaigns
  has_many :entries

  before_validation :clean_reply_to

  validates_presence_of :subject_line
  validates_presence_of :title
  validates_presence_of :from_name
  validates_presence_of :reply_to
  validates_format_of   :reply_to, :with => EMAIL_REGEX, allow_blank: true, allow_nil: true
  # validates_presence_of :api_key

  after_create    :create_campaign
  after_update    :update_campaign
  # after_destroy :destroy_campaign

  private
    def clean_reply_to
      self.reply_to = reply_to.downcase.strip if reply_to.present?
    end

    def create_campaign
      CreateCampaignJob.perform_later(self.id)
    end

    def update_campaign
      CreateCampaignJob.perform_later(self.id, 'update')
    end

end
