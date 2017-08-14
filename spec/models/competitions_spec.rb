require "rails_helper"

describe Competition do
  it "should require a name" do
    expect { create(:competition_email_only, name: "") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should create slug" do
    competition = create(:competition_name_email)
    expect(competition.slug).to eq("name-email-comp")
  end
end
