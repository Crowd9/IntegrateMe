#
# Mailchimp Integration
#
module IntegrateMe
  module Optin
    class MailchimpApi < Base
      #
      # Checks connection
      #
      # @returns [Boolean] result
      def connect
        self.agent
        true
      rescue => e
        Rails.logger.warn(e)
        false
      end

      #
      # Call to trigger integration
      #
      # @returns [Boolean] result
      def execute(contact, list = nil)
        @contact = contact
        @list = list
        list_subscribe
      end

      #
      # Gets list of subscribers
      #
      # Arrays with [list_id, list_name]
      #
      # @returns [Array] list
      def lists
        @lists ||= self.agent.lists.list['data'].map do |list|
          [list['id'], list['web_id'], list['name']]
        end
      end

      protected

      #
      # Mechanize agent
      #
      # @returns [Mechanize] agent
      def agent
        @agent ||= Mailchimp::API.new(api_key)
      end

      #
      # Gets first list from mailchimp
      #
      # @returns [String] list id
      def list_to_subscribe
        list || lists.first
      end

      #
      # Creates the new subscriber contact on the first found list
      #
      # @returns [Boolean] result
      def list_subscribe
        return false unless list_to_subscribe.present?
        agent.lists.subscribe(
          list_to_subscribe[0], { email: contact.email }, merge_vars, 'html', false
        )
      rescue Mailchimp::ListAlreadySubscribedError
        Rails.logger.info "#{contact.email} is already subscribed to the list"
        true
      rescue => e
        Rails.logger.warn "Mailchimp list_subscribe error: #{e}"
        false
      end

      #
      # Contact hash
      #
      # @return [Hash] contact hash
      def merge_vars
        {
          'FNAME' => contact.first_name,
          'LNAME' => contact.last_name,
          optin_time: contact.created_at
        }.select { |_k, v| v.present? }
      end
    end
  end
end
