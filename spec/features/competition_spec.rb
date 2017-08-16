require 'rails_helper'

feature "Home page" do
  scenario "shows two competitions" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    expect(page).to have_content(competition_name_email.name)
    expect(page).to have_content(competition_email_only.name)
  end

  scenario "goes to join name and email competition page and creates valid entry" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    click_link competition_name_email.name

    fill_in 'email', :with => Faker::Internet.email
    fill_in 'name', :with => Faker::Name.name

    click_button("Enter!")

    expect(page).to have_content('Thank you for entering our competition!')
  end

  scenario "goes to join email only competition page and creates valid entry" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    click_link competition_email_only.name

    fill_in 'email', :with => Faker::Internet.email

    click_button("Enter!")

    expect(page).to have_content('Thank you for entering our competition!')
  end

  scenario "goes to join email only competition page without entering email and gets validation error" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    click_link competition_email_only.name

    click_button("Enter!")

    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario "goes to join email name competition page without entering email and gets validation error" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    click_link competition_name_email.name

    fill_in 'name', :with => Faker::Name.name

    click_button("Enter!")

    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario "goes to join email name competition page without entering name and gets validation error" do
    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    click_link competition_name_email.name

    fill_in 'email', :with => Faker::Internet.email

    click_button("Enter!")

    expect(page).to have_content('Sorry, there was a problem saving your entry:')
  end

  scenario "goes to login page and enter right credentials, login and edit competition with wrong api key" do
    user = create(:user)

    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    visit new_user_session_path

    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => "Test:2017"

    click_button("Log in")

    first(:link, "Edit").click

    expect(page).to have_content('Edit')

    fill_in 'api_key', :with => "wrongapikey"

    click_button("Get MailChimp Lists")

    #expect(page).to have_content('Please provide valid Mailchimp API key.')
  end

  scenario "goes to edit competition page and enters right credentials, login and edit competition with right api key" do
    user = create(:user)

    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    visit new_user_session_path

    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => "Test:2017"

    click_button("Log in")

    first(:link, "Edit").click

    expect(page).to have_content('Edit')

    fill_in 'api_key', :with => Rails.application.secrets.mailchimp[:api_key]

    click_button("Get MailChimp Lists")

    #select "nonprofit", :from => "mail_lists"


  end

  scenario "goes to edit competition page without entering right credentials and not rendered competition edit page" do
    user = create(:user)

    competition_name_email = create(:competition_name_email)
    competition_email_only = create(:competition_email_only)

    visit root_path

    visit new_user_session_path

    fill_in 'user[email]', :with => user.email
    fill_in 'user[email]', :with => "wrongpassword"

    click_button("Log in")

    expect(page).not_to have_content('Edit')
  end
end
