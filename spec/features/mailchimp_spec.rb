require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Mailchimp', type: :feature do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as user, scope: :user
  end

  context 'create' do
    let(:campaign) { FactoryGirl.build_stubbed(:campaign) }

    scenario 'campaigns' do
      visit campaigns_path
      expect(page).to have_text 'Campaigns'
      expect(page).to have_link 'New Campaign'
      page.click_link 'New Campaign'

      expect(page).to have_text 'New Campaign'
      fill_in 'title', with: campaign.title
      fill_in 'subject_line', with: campaign.subject_line
      fill_in 'from_name', with: campaign.from_name
      fill_in 'reply_to', with: campaign.reply_to
      page.click_button 'Create Campaign'

      expect(page).to have_text 'Campaign was successfully created.'
    end
  end

  context 'create' do
    let(:campaign) { FactoryGirl.build_stubbed(:campaign) }
    let(:competition) { FactoryGirl.create(:competition) }
    let(:entry) { competition.entries.create! name: Faker::Name.name, email: Faker::Internet.email }
    subject{ entry }

    scenario 'contact' do
      visit enterant_path(competition, permalink: 'nameemail-comp')
      expect(page).to have_text 'Enter your details to win!'
      fill_in 'name', with: entry.name
      fill_in 'email', with: entry.email
      page.click_button 'Enter!'
      expect(page).to have_text 'Thank you for entering our competition!'
    end
  end

end
