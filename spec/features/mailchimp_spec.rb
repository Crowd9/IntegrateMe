require 'rails_helper'

RSpec.feature 'Mailchimp', type: :feature do

  context 'create' do
    let(:integration) { FactoryGirl.build(:mailchimp) }

    scenario 'integration' do
      visit integrations_path
      expect(page).to have_text 'Integrations'
      expect(page).to have_link 'New'
      page.click_link 'New'

      expect(page).to have_text 'New Integration'
      fill_in 'integration[api_key]', with: integration.api_key
      fill_in 'integration[name]', with: integration.name
      select integration.type, from: 'integration[type]'
      page.click_button 'Create Integration'

      expect(page).to have_text 'Mailchimp api was successfully created'
    end
  end

  context 'create' do
    let(:contact) { FactoryGirl.build(:contact) }

    scenario 'contact' do
      visit contacts_path
      expect(page).to have_text 'Contacts'
      expect(page).to have_link 'New'
      page.click_link 'New'

      expect(page).to have_text 'New Contact'
      fill_in 'contact[name]', with: contact.name
      fill_in 'contact[email]', with: contact.email
      page.click_button 'Create Contact'

      expect(page).to have_text 'Contact was successfully created'
    end
  end

  context 'mailchimp optin' do
    let(:integration) { FactoryGirl.create(:mailchimp) }
    let(:contact) { FactoryGirl.create(:contact, email: 'test_email_123@gmail.com') }
    let(:list_id) { integration.integrated_app.send(:list)[0] }
    let(:mailchimp) { Mailchimp::API.new(integration.api_key) }
    let(:members) { mailchimp.lists.members(list_id)['data'].map{ |member| member['email'] } }

    subject do
      VCR.use_cassette('features/mailchimp/members') do
        members
      end
    end 

    before do
      VCR.use_cassette('features/mailchimp/optin') do
        @contact_api_data = integration.queue(contact)
      end
    end

    it { should include 'test_email_123@gmail.com' }
  end
end
