class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(entry)
    gibbon = Gibbon::API.new
    gibbon.lists.subscribe({:id => ENV["MAILCHIMP_LIST_ID"], :email => {:email => entry.email},:merge_vars => {:NAME => entry.name}, :double_optin => false})
  end
end
