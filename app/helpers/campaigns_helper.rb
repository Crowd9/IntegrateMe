module CampaignsHelper

  def campaigns_init(campaign)
    {
        campaign: {
        id: campaign.id,
        title: campaign.title,
        subject_line: campaign.subject_line,
        from_name: campaign.from_name,
        reply_to: campaign.reply_to,
        api_key: campaign.api_key
    }
    }.to_json
  end

end
