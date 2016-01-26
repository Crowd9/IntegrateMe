class Entry < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%a-z\-+]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,12}\z/

  belongs_to :competition

  before_validation :clean_email

  validates_presence_of :competition, inverse_of: :entries
  validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX, allow_blank: true, allow_nil: true
  validates_presence_of :name, if: :requires_name
  validates_uniqueness_of :email, scope: :competition, message: "has already entered this competition"

  after_create :mark_as_new
  after_update :need_to_sync_with_mailchimp?
  after_commit :sync_with_mailchimp

  private
    def clean_email
      self.email = email.downcase.strip if email.present?
    end

    def requires_name
      competition.requires_entry_name?
    end

    def mark_as_new
      @sync_with_mailchimp = true
    end

    def need_to_sync_with_mailchimp?
      if self.email_changed?
        @sync_with_mailchimp = true
        @unsubscribed_email = self.email_was
      end
    end

    def sync_with_mailchimp
      if @sync_with_mailchimp.present? || @unsubscribed_email.present?
        mailchimp_setting = Setting.mailchimp_setting
        if mailchimp_setting.present? && mailchimp_setting.raw["List Id"].present?
          mailchimp_client = MailchimpClient::List.new(mailchimp_setting.raw["API Key"])
        else
          mailchimp_client = nil
        end

        if mailchimp_client.present?
          if @sync_with_mailchimp
            mailchimp_client.subscribe(mailchimp_setting.raw["List Id"], {"EMAIL" => self.email})
          end

          if @unsubscribed_email.present?
            mailchimp_client.unsubscribe(mailchimp_setting.raw["List Id"], {"EMAIL" => self.email})
          end
        end
      end
    end
end
