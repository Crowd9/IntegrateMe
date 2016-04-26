class CreateCampaignJob < ActiveJob::Base
  queue_as :default

  def perform(campaign)

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

    # what if the key is wrong
    gibbon = Gibbon::Request.new(api_key: campaign.api_key)

    begin
      gibbon.campaigns.create(body: body)
    rescue Gibbon::MailChimpError => e
      logger.info "#{e.message} - #{e.raw_body}"
      puts "sleeping ... retrying ..."
      sleep 5
      retry  # restart from beginning
    end

  end
end
