require "rails_helper"

describe Entry do
  it "should require a name" do
    expect { Competition.create!(name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "sync with mailchimp" do
    let!(:setting) {
      FactoryGirl.create(:setting, :code => :mailchimp_api,
                                   :raw => {
                                     "API Key" => SecureRandom.hex(16) + "-us8",
                                     "List Name" => Faker::Name.name,
                                     "List Id" => SecureRandom.hex(4)
                                    })
    }
    let(:entry) { FactoryGirl.build(:entry) }

    it "should subscribe to mailchimp when create new entry" do
      mailchimp_api = double(:mailchimp_api)
      allow(Mailchimp::API).to receive(:new).and_return(mailchimp_api)
      mailchimp_list = double(:mailchimp_list)
      allow(mailchimp_api).to receive(:lists).and_return(mailchimp_list)
      allow(mailchimp_list).to receive(:batch_subscribe).and_return(true)
      allow_any_instance_of(MailchimpClient::List).to receive(:subscribe).and_return(true)
      expect_any_instance_of(MailchimpClient::List).to receive(:subscribe).with(setting.raw["List Id"], {"EMAIL" => entry.email})
      expect(entry.save).to be_truthy
    end

    it "should subscribe to mailchimp when email was changed" do
      mailchimp_api = double(:mailchimp_api)
      allow(Mailchimp::API).to receive(:new).and_return(mailchimp_api)
      mailchimp_list = double(:mailchimp_list)
      allow(mailchimp_api).to receive(:lists).and_return(mailchimp_list)
      allow(mailchimp_list).to receive(:batch_subscribe).and_return(true)
      allow_any_instance_of(MailchimpClient::List).to receive(:subscribe).and_return(true)

      expect(entry.save).to be_truthy

      new_email = Faker::Internet.email
      allow(mailchimp_list).to receive(:batch_unsubscribe).and_return(true)
      expect_any_instance_of(MailchimpClient::List).to receive(:subscribe).with(setting.raw["List Id"], {"EMAIL" => new_email})

      expect(entry.update_attributes(:email => new_email)).to be_truthy
    end

    it "should unsubscribe old email to mailchimp when email was changed" do
      mailchimp_api = double(:mailchimp_api)
      allow(Mailchimp::API).to receive(:new).and_return(mailchimp_api)
      mailchimp_list = double(:mailchimp_list)
      allow(mailchimp_api).to receive(:lists).and_return(mailchimp_list)
      allow(mailchimp_list).to receive(:batch_subscribe).and_return(true)
      allow_any_instance_of(MailchimpClient::List).to receive(:subscribe).and_return(true)

      expect(entry.save).to be_truthy

      old_email = entry.email
      new_email = Faker::Internet.email
      allow(mailchimp_list).to receive(:batch_unsubscribe).and_return(true)
      expect_any_instance_of(MailchimpClient::List).to receive(:unsubscribe).with(setting.raw["List Id"], {"EMAIL" => old_email})
      expect(entry.update_attributes(:email => new_email))
    end
  end
end
