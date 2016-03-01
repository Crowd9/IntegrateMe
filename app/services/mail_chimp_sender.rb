class MailChimpSender
  def initialize(options = {})
    @entry   = options[:entry]
    @list_id = options[:list_id]
  end

  def subscribe
    api_key = ENV['MAILCHIMP_API_KEY']

    if api_key.blank?
      return "ENV['MAILCHIMP_API_KEY'] is not set"
    end

    if @list_id.blank?
      return "List id is not set"
    end

    # NB requires ENV['MAILCHIMP_API_KEY'] to be set; this value is not stored
    # in version control
    gibbon = Gibbon::Request.new

    begin
      gibbon.lists(@list_id).members.create(
       body: {
                email: @entry.email,
                merge_fields: {NAME: @entry.name}
             }
      )
    rescue Gibbon::MailChimpError => gme
      error = gme.message
    end
    error
  end
end