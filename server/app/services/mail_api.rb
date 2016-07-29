class MailApi
  def initialize(api_key, debug: false)
    @api_key = api_key
    @gibbon = Gibbon::Request.new(api_key: api_key, debug: debug)
  end
  
  def check_list(list_id)
    @gibbon.lists(list_id).retrieve
    return nil
  rescue Gibbon::MailChimpError => e
    if e.status_code == 404
      return "mail list not found by id=#{list_id}"
    elsif e.status_code == 401
      return "wrong api key #{@api_key}"
    else
      return "MailChimp responce: #{e.title || e}"
    end
  end

  def add_member_to_list(list_id, email, name)
    @gibbon.lists(list_id).members.create(
      body: {
        email_address: email,
        status: 'subscribed',
        merge_fields: { FNAME: name }
      }
    )
  rescue Gibbon::MailChimpError => e
    raise "MailChimp responce: #{e.title || e}"
  end
end
