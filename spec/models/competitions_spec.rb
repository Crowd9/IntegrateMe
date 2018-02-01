require "rails_helper"

describe Competition do
  let(:valid_competition) { build :competition }
  let(:competition_without_name) { create :competition, name: nil }

  it 'should require a name' do
    expect { competition_without_name }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'sould be able to create a competition' do
    expect(valid_competition).to be_valid
  end

end