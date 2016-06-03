require 'rails_helper'

feature 'Competition creation' do
  let(:mail_chimp_credentials) { YAML.load_file('spec/fixtures/mail_chimp.yml').with_indifferent_access }
  scenario 'without list selected' do
    visit root_path
    fill_in 'Name', with: 'the best rider in the galaxy'
    uncheck 'Requires entry name?'
    fill_in 'Runner email', with: 'anakin@example.com'
    fill_in 'MailChimp List', with: mail_chimp_credentials[:api_key]
    click_on '>'
    sleep(2)
    within('#new_competition_mail_chimp_list_id') do
      find("option[value='#{mail_chimp_credentials[:list_id]}']").select_option
    end
    click_on 'Create!'
    sleep(2)
    expect(page.find('.competitions-list')).to have_content('the best rider in the galaxy')
  end
end
