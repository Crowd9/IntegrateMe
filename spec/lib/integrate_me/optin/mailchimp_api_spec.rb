require 'rails_helper'

RSpec.describe IntegrateMe::Optin::MailchimpApi do

  let(:integration) { FactoryGirl.build_stubbed(:mailchimp) }
  let(:contact) { FactoryGirl.build_stubbed(:contact) }
  let(:mailchimp_api) { IntegrateMe::Optin::MailchimpApi.new(integration.api_key) }

  describe 'connect' do
    subject do
      VCR.use_cassette('mailchimp/connect') do
        mailchimp_api.connect
      end
    end 
    it { should be_truthy }
  end

  describe 'execute' do
    let(:result) do
      {
        "email"=>"lewis@schmeler.info",
        "euid"=>"0adf06e345",
        "leid"=>"75179029"
      }
    end

    subject do
      VCR.use_cassette('mailchimp/execute') do
        mailchimp_api.execute(contact)
      end
    end 

    it { should eq result }
  end
end
