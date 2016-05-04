require 'rails_helper'

RSpec.describe SubscribeUserToMailingListJob, type: :job do
  it "should subscribe the email and name to the mailing list" do
    entry = create(:entry)
    SubscribeUserToMailingListJob.perform_later(entry)
  end

end
