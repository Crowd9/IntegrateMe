class MailchimpService

  def initialize
    @client = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp[:api_key])
  end

  def subscribe(entry)
    begin
      if entry.name.present?
        @client.lists(Rails.application.secrets.mailchimp[:list_id]).members.create(body: {email_address: entry.email, status: "subscribed", merge_fields: {NAME: entry.name}})
      else
        @client.lists(Rails.application.secrets.mailchimp[:list_id]).members.create(body: {email_address: entry.email, status: "subscribed"})
      end
    rescue => e
      Rails.logger.debug("-- Mailchimp DEBUG: #{e}")
    end
  end
end
