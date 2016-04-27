require "rails_helper"

describe MailchimpClient::List do
  let(:api_key) {SecureRandom.hex(16) + "-us8"}
  let(:list_id) {SecureRandom.hex(4)}
  let(:list_name) {Faker::Name.name}
  let(:subscribers) {[{"EMAIL" => Faker::Internet.email}]}

  before(:each) do
    @mailchimp_api = double(:mailchimp_api)
    allow(Mailchimp::API).to receive(:new).and_return(@mailchimp_api)
    @mailchimp_list = double(:mailchimp_list)
    allow(@mailchimp_api).to receive(:lists).and_return(@mailchimp_list)
  end

  describe "#subscribe" do
    it "should call subscribe method of Mailchimp List API" do
      subs = []
      subscribers.each do |subscriber|
        sub = {
          :EMAIL => {:email => subscriber["EMAIL"]},
          :merge_vars => {"EMAIL" => subscriber["EMAIL"]}
        }

        subs << sub
      end
      expect(@mailchimp_list).to receive(:batch_subscribe).with(list_id, subs, false, true, true)
      mc = MailchimpClient::List.new(api_key)
      mc.subscribe(list_id, subscribers)
    end
  end

  describe "#unsubscribe" do
    it "should call subscribe method of Mailchimp List API" do
      subs = []
      subscribers.each do |subscriber|
        sub = {
          :EMAIL => {:email => subscriber["EMAIL"]},
          :merge_vars => {"EMAIL" => subscriber["EMAIL"]}
        }

        subs << sub
      end

      expect(@mailchimp_list).to receive(:batch_unsubscribe).with(list_id, subs, false, true, false)
      mc = MailchimpClient::List.new(api_key)
      mc.unsubscribe(list_id, subscribers)
    end
  end

  describe "#find_list_id_by_name" do
    it "should return id if list name exists" do
      allow(@mailchimp_list).to receive(:list).and_return({"data" => [{"id" => list_id, "name" => list_name}]})
      mc = MailchimpClient::List.new(api_key)
      expect(mc.find_list_id_by_name(list_name)).to eql(list_id)
    end

    it "should return nil if list name does not exist" do
      allow(@mailchimp_list).to receive(:list).and_return({"data" => [{"id" => list_id, "name" => Faker::Name.name}]})
      mc = MailchimpClient::List.new(api_key)
      expect(mc.find_list_id_by_name(list_name)).to be_nil
    end
  end
end
