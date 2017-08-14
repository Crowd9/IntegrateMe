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
end
