class Setting < ActiveRecord::Base
  CODES = {
    :mailchimp_api => "Mailchimp API key"
  }

  enum :code => CODES.keys
  serialize :raw, Hash

  validates_presence_of :code, :raw
  validates_uniqueness_of :code

  before_save :remove_list_id
  after_commit :get_list_id

  def self.search(params = {})
    # TODO: Change to include user_id if this app has user.
    scope = self.all
    params.each do |k, v|
      key = k.to_s
      v = value

      if key == "code"
        scope = scope.where(:code => self.codes[value.to_sym])
      end
    end

    scope
  end

  def self.mailchimp_setting
    self.where(:code => self.codes[:mailchimp_api]).first
  end

  private

    def remove_list_id
      self.raw.delete("List Id") if self.raw_changed? && self.raw && self.raw_was.try(:[], "List Name") != self.raw["List Name"]
    end

    def get_list_id
      if self.raw["List Name"].present? && !self.raw["List Id"]
        mailchimp_setting = Setting.mailchimp_setting
        if mailchimp_setting.present?
          mailchimp_client = MailchimpClient::List.new(mailchimp_setting.raw["API Key"])
          raw = self.raw.merge("List Id" => mailchimp_client.find_list_id_by_name(self.raw["List Name"]))
          self.update_attributes!(:raw => raw)
        end
      end
    end
end
