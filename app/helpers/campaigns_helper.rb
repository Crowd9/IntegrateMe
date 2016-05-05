module CampaignsHelper

  def campaigns_init(campaign)
    {
        campaign: {
        id: campaign.id,
        title: campaign.title,
        # subject_line: campaign.subject_line,
        # from_name: campaign.from_name,
        # reply_to: campaign.reply_to,
        api_key: campaign.mailchimp_id,
        action: campaign.new_record? ? 'Create' : 'Update',
        list_id: campaign.list_id,
        lists: get_mailchimp_lists(campaign)
      }
    }.to_json
  end

  def get_mailchimp_lists(campaign)
    h=[]
    gibbon = Gibbon::Request.new(api_key: campaign.mailchimp_id)
    lists = gibbon.lists.retrieve
    lists['lists'].each{|list| h << {name:list['name'], id:list['id']}}
    # lists['lists'].inject({}) {|h, res| h[res['name']]=res['id'];h}
    h
  end

end
