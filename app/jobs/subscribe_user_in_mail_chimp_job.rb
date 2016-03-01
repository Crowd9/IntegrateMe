class SubscribeUserInMailChimpJob < ActiveJob::Base
  class SubscribeOptionsError < StandardError; end

  queue_as :default

  def perform(entry, opts = {})
    Entry.transaction do
      # handles re-submission of failed entries, avoid race condition
      unless entry.mail_chimp_subscribed?
        exception = nil

        begin
          api_key = ENV['MAILCHIMP_API_KEY']
          if api_key.blank?
            raise SubscribeOptionsError.new("ENV['MAILCHIMP_API_KEY'] is not set")
          end

          list_id = opts[:list_id]
          if list_id.blank?
            raise SubscribeOptionsError.new("List id not provided")
          end
        rescue SubscribeOptionsError => soe
          exception = soe
          Rails.logger.error("MailChimp subscribe failed, bad options: #{soe.message}")
        end

        if exception.nil?
          gibbon = Gibbon::Request.new

          request_data = {
            body: {
              email_address: entry.email,
              status: "subscribed",
            }
          }

          unless entry.name.blank?
            request_data[:body][:merge_fields] = {NAME: entry.name}
          end

          begin
            gibbon.lists(list_id).members.create(request_data)
          rescue Gibbon::MailChimpError => gme
            exception = gme
            Rails.logger.error("MailChimp subscribe failed, Gibbon error: #{gme.message}")
          end
        end
        entry.update_attribute(:mail_chimp_subscribed, exception.nil?)
      end
    end
  end
end
