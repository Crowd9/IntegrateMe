require 'rails_helper'

feature 'name and email entered', :js => true do
  let(:competition_data) { {name: "Name+Email comp", requires_entry_name: true} }

  let(:name) { 'Jane Doe' }
  # can't use example.* as mailchimp rejects them
  let(:valid_email) { 'jdoe@madeupdomain.org' }
  let(:invalid_email) { 'jdoe' }

  before do
    Competition.create!(competition_data)
    visit '/'
    click_link(competition_data[:name])
  end

  scenario 'with name and valid email' do
    fill_in('Name', :with => name)
    fill_in('Email', :with => valid_email)
    click_on('Enter!')
    expect(page).to have_content('Thank you for entering our competition!')
  end

  scenario 'with name and blank email' do
    fill_in('Name', :with => name)
    fill_in('Email', :with => '')
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario 'with name and invalid email' do
    fill_in('Name', :with => name)
    fill_in('Email', :with => invalid_email)
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario 'with blank name and valid email' do
    fill_in('Name', :with => '')
    fill_in('Email', :with => valid_email)
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario 'with blank name and blank email' do
    fill_in('Name', :with => '')
    fill_in('Email', :with => '')
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario 'with blank name and invalid email' do
    fill_in('Name', :with => '')
    fill_in('Email', :with => invalid_email)
    click_on('Enter!')
    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

end