#
# Mailchimp integration
#
class MailchimpApi < Integration
  validates :name, :api_key, presence: true

  #
  # List of subscriptions
  #
  # @return [Array] list
  def lists
    integrated_app.try(:lists)
  end

  #
  # Queyes an integration job
  #
  # @param [Contact] contact
  def queue(contact)
    integrated_app.try(:execute, contact, list)
  end
end
