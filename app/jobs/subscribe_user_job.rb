class SubscribeUserJob < ActiveJob::Base
  queue_as :default

  def perform(entry, action='create')

    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])

    @body = {}
    @body[:email_address] = entry.email
    @body[:status] = "subscribed"
    @body[:merge_fields] = {FNAME: entry.first_name, LNAME: entry.last_name} if entry.name

    case action
      when 'create'
        create(entry)
      when 'edit'
        edit(entry)
    end

  end

  def create(entry)
    puts "===create entry"
    begin
      @gibbon.lists( ENV['MAILCHIMP_LIST_ID'] ).members.create(body: @body)
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      if e.title =~ /Member Exists/
        puts "member exist: #{entry.inspect} === removing"
        entry.delete
      else
        puts 'sleeping ... retrying ...'
        sleep 5
        retry
      end
    end
  end

  def edit(entry)
    puts "===edit entry"
    md5_email = Digest::MD5.hexdigest entry.email
    begin
      @gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members(md5_email).upsert(body: @body)
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      puts 'sleeping ... retrying ...'
      sleep 5
    end
  end

end
