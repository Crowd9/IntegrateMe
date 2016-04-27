class Contact < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, email: true

  after_create 'delay.queue_integrations'

  #
  # Queues integrations to Sidekiq
  #
  def queue_integrations
    Integration.all.each { |integration| integration.queue(self) }
  end

  #
  # First name
  #
  # @returns [String] first name
  def first_name
    name.split(' ').first
  end

  #
  # Last name
  #
  # @returns [String] last name
  def last_name
    name.split(' ').try(:[], 1)
  end
end
