module MailchimpClient
  class List
    attr_accessor :mailchimp_api

    def initialize(api_key)
      @mailchimp_api = Mailchimp::API.new(api_key)
    end

    def subscribe(list_id, subscribers, send_notify = false, update_existing = true, replace_interests = true)
      subs = standardize_subscribers(subscribers)
      @mailchimp_api.lists.batch_subscribe(list_id, subs, send_notify, update_existing, replace_interests)
    end

    def unsubscribe(list_id, subscribers, delete_member = flase, send_goodbye = true, send_notify = false)
      subs = standardize_subscribers(subscribers)
      MailchimpApi.lists.batch_unsubscribe(list_id, subs, delete_member, send_goodbye, send_notify)
    end

    def find_list_id_by_name(list_name)
      lists = @mailchimp_api.lists.list
      lists["data"].each do |list|
        return list["id"] if list["name"] == list_name
      end

      return nil
    end

    private

    def standardize_subscribers(subscribers)
      subs = subscribers
      subs = [subs] unless subs.kind_of?(Array)

      results = []
      subs.each do |sub|
        if sub.kind_of?(Hash)
          result = {
            :EMAIL => {:email => sub["EMAIL"]},
            :merge_vars => {"EMAIL" => sub["EMAIL"]}
          }

          result[:merge_vars]["FNAME"] = sub["FNAME"] if sub["FNAME"].present?
          result[:merge_vars]["LNAME"] = sub["LNAME"] if sub["LNAME"].present?

          results << result
        else
          results << sub
        end
      end

      results
    end
  end
end
