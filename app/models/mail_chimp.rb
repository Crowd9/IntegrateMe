require 'sqlite3'
require 'gibbon'

class MailChimp
  API_KEY = '89f98d2f062c17ddb5b9414c23d72011-us16'
  LIST_ID = '48af1e84e4'

  def fetch_latest_entry(entry)
    if entry.competition_id == 2
      @first_name = entry.email[0...entry.email.index("@")]
      @last_name = entry.email[(entry.email.index("@") + 1)..-1]
      puts "first name = #{@first_name}"
      puts "last name = #{@last_name}"
    else
      split_name = entry.name.split(" ")
      if split_name[1] == nil
        @first_name = split_name[0]
        @last_name = "nil"
      else
        @first_name = split_name[0]
        @last_name = split_name[1]
      end
    end
    @latest_entry_email = entry.email # results.flatten[3]
  end

  def subscribe_to_mail_chimp(entry)
    fetch_latest_entry(entry)
    gibbon = Gibbon::Request.new(api_key: API_KEY, debug: false)
    gibbon.timeout = 30
    gibbon.open_timeout = 30

    subscribe_user_to_mailing_list = gibbon.lists(LIST_ID).members.create(body:
    {
      email_address: @latest_entry_email,
      status: "subscribed",
      merge_fields: {FNAME: @first_name, LNAME: @last_name}
      })
  end
end
