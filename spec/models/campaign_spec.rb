require 'rails_helper'

RSpec.describe Campaign, type: :model do

  let(:campaign) { FactoryGirl.build_stubbed(:campaign) }

  describe 'subject_line' do
    it { should validate_presence_of :subject_line }
  end

  describe 'title' do
    it { should validate_presence_of :title }
  end

  describe 'from_name' do
    it { should validate_presence_of :from_name }
  end

  describe 'reply_to' do
    it { should validate_presence_of :reply_to }
    # it { should validate_format_of :reply_to }
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        campaign.reply_to = invalid_address
        expect(campaign).not_to be_valid
      end
    end
  end

  describe 'create_campaign' do

    it "queues job when a campaign is created" do
      expect do
        FactoryGirl.create(:entry)
      end.to change{Delayed::Job.count}.by(1)
    end

    it 'should create campaign over mailchimp api' do
      gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
      before_create_count = gibbon.campaigns.retrieve['total_items']
      FactoryGirl.create(:campaign)
      Delayed::Worker.new.work_off
      after_create_count = gibbon.campaigns.retrieve['total_items']
      expect(after_create_count).to eq(before_create_count+1)
    end

  end


end
