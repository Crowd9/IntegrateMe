require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:competition_with_email) { build :competition, requires_entry_name: false }
  let(:competition_with_email_and_name) { build :competition, requires_entry_name: true }
  let(:valid_entry_without_name) { build :entry, name: nil, competition: competition_with_email }
  let(:valid_entry_with_name) { build :entry, competition: competition_with_email_and_name }
  let(:invalid_entry_without_name) { build :entry, name: nil, competition: competition_with_email_and_name }
  let(:invalid_entry_without_email) { build :entry, email: nil }
  let(:invalid_entry_with_wrong_email_format) { build :entry, email: 'wrong_format.com' }

  it 'should be able to create an entry to a competition with email only' do
    expect(valid_entry_without_name).to be_valid
  end

  it 'should be able to create an entry to a competition with email and password' do
    expect(valid_entry_with_name).to be_valid
  end

  it 'should not create an entry without name to a competition that requires name' do
    expect(invalid_entry_without_name).not_to be_valid
  end

  it 'should not be able to create an entry without email' do
    expect(invalid_entry_without_email).not_to be_valid
  end
  
  it 'should not be able to create an entry without a competition' do
    expect(invalid_entry_with_wrong_email_format).not_to be_valid
  end
end
