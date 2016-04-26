class SubscribeUserJob < ActiveJob::Base
  queue_as :default

  def perform(entry, api_key)

    gibbon = Gibbon::Request.new(api_key: api_key)

    begin
      gibbon.lists(
        ENV['MAILCHIMP_LIST_ID']).members.create(body:
        {
          email_address: entry.email,
          status: "subscribed",
          merge_fields: {FNAME: entry.first_name, LNAME: entry.last_name}
        }
      )
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      puts "sleeping ... retrying ..."
      sleep 5
      retry  # restart from beginning
    end

  end

end
