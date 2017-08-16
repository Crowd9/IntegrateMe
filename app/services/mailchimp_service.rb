class MailchimpService

  def initialize(api_key)
    @client = Gibbon::Request.new(api_key: api_key)
  end

  def subscribe(entry, mailchimp_list_id)
    begin
      if entry.name.present?
        @client.lists(mailchimp_list_id).members.create(body: {email_address: entry.email, status: "subscribed", merge_fields: {NAME: entry.name}})
      else
        @client.lists(mailchimp_list_id).members.create(body: {email_address: entry.email, status: "subscribed"})
      end
    rescue => e
      Rails.logger.debug("-- Mailchimp DEBUG: #{e}")
    end
  end

  def get_lists
    begin
      return @client.lists.retrieve(params: {"fields" => "lists.id,lists.name"})
    rescue => e
      return "Please provide valid Mailchimp API key."
    end
  end
end
