class SubscribeUserJob < ActiveJob::Base
  queue_as :default

  def perform(entry, api_key)

    gibbon = Gibbon::Request.new(api_key: api_key)

    body = {}
    body[:email_address] = entry.email
    body[:status] = "subscribed"
    body[:merge_fields] = {FNAME: entry.first_name, LNAME: entry.last_name} if entry.name

    begin
      gibbon.lists( ENV['MAILCHIMP_LIST_ID'] ).members.create( body: body )
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      puts "sleeping ... retrying ..."
      sleep 5
      retry  # restart from beginning
    end

  end

end
