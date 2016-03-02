require 'rails_helper'

feature 'email entered', js: true do
  let(:competition_data) { {id: 5, name: "Email only comp", requires_entry_name: false} }

  # can't use example.* as mailchimp rejects them
  let(:valid_email) { 'jdoe@madeupdomain.org' }
  let(:invalid_email) { 'jdoe' }

  before do
    Competition.create!(competition_data)
    visit '/'
    click_link(competition_data[:name])
  end

  scenario 'with valid email' do
    fill_in('Email', with: valid_email)
    click_on('Enter!')
    expect(page).to have_content('Thank you for entering our competition!')
  end

  scenario 'with blank email' do
    fill_in('Email', with: '')
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario 'with invalid email' do
    fill_in('Email', with: invalid_email)
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

end