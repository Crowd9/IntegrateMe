class CreateCampaignJob < ActiveJob::Base
  queue_as :default

  def perform(campaign_id, action='create')

    campaign = Campaign.find_by id: campaign_id

    recipients = {
        list_id: ENV['MAILCHIMP_LIST_ID']
    }

    settings = {
        subject_line: campaign.subject_line,
        title: campaign.title,
        from_name: campaign.from_name,
        reply_to: campaign.reply_to
    }

    body = {
        type: "regular", #hardcoding it for a while
        recipients: recipients,
        settings: settings
    }

    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])

    case action
      when 'create'
        begin
          result = gibbon.campaigns.create(body: body)
          campaign.update_attributes mailchimp_id: result['id']
        rescue Gibbon::MailChimpError => e
          logger.info "#{e.message} - #{e.raw_body}"
          puts "sleeping ... retrying ..."
          sleep 5
          retry  # restart from beginning
        end

      when 'update'
        begin
          result = gibbon.campaigns(campaign.mailchimp_id).update(body: body)
        rescue Gibbon::MailChimpError => e
          logger.info "#{e.message} - #{e.raw_body}"
          puts "sleeping ... retrying ..."
          sleep 5
          retry  # restart from beginning
        end
    end


  end
end
