require "rails_helper"

describe Competition do
  it "requires a name" do
    expect { Competition.create!(name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end