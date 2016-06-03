module MailChimpAdapter
  class GibbonAdapter
    include ActiveSupport::Rescuable

    rescue_from Gibbon::MailChimpError do |err|
      raise MailChimpAdapter::MailChimpError, "#{err.title}: #{err.detail}"
    end

    rescue_from Gibbon::GibbonError do |err|
      raise MailChimpAdapter::MailChimpError, err.message
    end

    def initialize(api_key:, debug: false)
      @gibbon = Gibbon::Request.new(api_key: api_key, debug: debug)
    end

    def all_lists
      gibbon.lists.retrieve
    rescue => err
      rescue_with_handler(err) || raise
    end

    def find_list(list_id)
      response = gibbon.lists(list_id).retrieve
    rescue => err
      rescue_with_handler(err) || raise
    end

    def add_member_to_list(list_id, email:)
      gibbon.lists(list_id).members.create(
        body: {
          email_address: email,
          status: 'subscribed'
        }
      )
    rescue => err
      rescue_with_handler(err) || raise
    end

    private

    attr_reader :gibbon
  end
end
