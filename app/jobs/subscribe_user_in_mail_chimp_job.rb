class SubscribeUserInMailChimpJob < ActiveJob::Base
  class SubscribeOptionsError < StandardError; end

  queue_as :default

  def perform(entry_id, list_id)
    Entry.transaction do
      # handles re-submission of failed entries, avoid race condition
      entry = Entry.find_by(id: entry_id)
      unless entry.nil? || entry.mail_chimp_subscribed?
        errors = []

        api_key = ENV['MAILCHIMP_API_KEY']
        if api_key.blank?
          errors << "ENV['MAILCHIMP_API_KEY'] is not set"
        end

        if list_id.blank?
          errors << "List id not provided"
        end

        if errors.present?
          Rails.logger.error("MailChimp subscribe failed: #{errors.join(';')}")
        else
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
            errors << gme.message
            Rails.logger.error("MailChimp subscribe failed, Gibbon error: #{gme.message}")
          end
        end
        entry.update_attribute(:mail_chimp_subscribed, errors.empty?)
      end
    end
  end
end
