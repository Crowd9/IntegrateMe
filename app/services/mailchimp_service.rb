class MailchimpService
  def initialize
    @gibbon = Gibbon::Request.new
    @list_id = Rails.application.secrets.mailchimp_list_id
  end

  def subscribe(name, email)
    data = { email_address: email, status: 'subscribed' }

    if name.present?
      first_name, last_name = name.split(' ', 2)
      data[:merge_fields] = { FNAME: first_name, LNAME: last_name || '' }
    end

    @gibbon.lists(@list_id).members.create(body: data)
  end
end
