require "rails_helper"

describe Entry do
  it "should require email" do
    competition = create(:competition_email_only)
    expect { create(:entry, email: "", competition: competition) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should require competition" do
    competition = create(:competition_email_only)
    expect { create(:entry) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should require a name if competition is with name" do
    competition = create(:competition_name_email)
    expect { create(:entry, name: "", competition: competition) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not require a name if competition is email only" do
    competition = create(:competition_email_only)
    expect(create(:entry, name: "", competition: competition)).to be_valid
  end

  it "should be valid with valid email, competition and name" do
    competition = create(:competition_name_email)
    expect(create(:entry, competition: competition)).to be_valid
  end

  it "should be unique email if it is same competition" do
    competition = create(:competition_name_email)

    create(:entry, email: "test@test.com", competition: competition)
    expect { create(:entry, email: "test@test.com", competition: competition) }.to raise_error(ActiveRecord::RecordInvalid)
  end


end
