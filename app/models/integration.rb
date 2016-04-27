#
# Base Integrations model
#
class Integration < ActiveRecord::Base
  self.table_name = 'integrations'

  TYPES = %w(MailchimpApi).freeze

  validates :type, inclusion: { in: TYPES }
  validate :successful_connection

  #
  # Class for our #decorate  records
  #
  # @return [Class]
  def self.decorator_class
    IntegrationDecorator
  end

  #
  # Integrated application like Aweber
  #
  # @return [ntegratedApp] application
  def integrated_app
    return unless type.present?

    # prevents calling the api many times
    @integrated_app ||= integration_class.new(api_key, api_token)
  rescue => e
    Rails.logger.warn(e)
    nil
  end

  #
  # Integrated application class
  #
  # @return [Class] class
  def integration_class
    "IntegrateMe::Optin::#{type}".constantize
  rescue => e
    Rails.logger.warn(e)
    nil
  end

  #
  # List of subscriptions
  #
  # @return [Array] lists
  def lists
    []
  end

  #
  # Queyes an integration job
  #
  # @param [Contact] contact
  def queue(contact)
    true
  end

  #
  # Checks if attribute is required 
  #
  # @param [Symbol] attribute
  #
  # @returns [Boolean] result 
  def required?(attribute)
    self.class.validators_on(attribute).map(&:class)
      .include?(ActiveRecord::Validations::PresenceValidator)
  end

  #
  # Successful connection validation
  #
  # @return [IntegratedApp] application
  def successful_connection
    connection = integrated_app.connect
    unless connection
      errors.add(:integration_name, "Failed to Successfully Connect - Verify Access Details")
    end
    connection
  rescue => e
    Rails.logger.warn(e)
    false
  end
end
