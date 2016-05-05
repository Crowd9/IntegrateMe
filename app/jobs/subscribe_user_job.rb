class SubscribeUserJob < ActiveJob::Base
  queue_as :default

  def perform(entry_id, action='create')

    entry = Entry.find_by id: entry_id
    api_key = entry.campaign.api_key

    @gibbon = Gibbon::Request.new(api_key: api_key)

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
    list_id = entry.campaign.list_id
    begin
      @gibbon.lists(list_id).members.create(body: @body)
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      if e.title =~ /Member Exists/
        entry.delete
      else
        puts 'sleeping ... retrying ...'
        sleep 5
        retry
      end
    end
  end

  def edit(entry)
    list_id = entry.campaign.list_id
    md5_email = Digest::MD5.hexdigest entry.email
    begin
      @gibbon.lists(list_id).members(md5_email).upsert(body: @body)
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      puts 'sleeping ... retrying ...'
      sleep 5
      retry
    end
  end

end
