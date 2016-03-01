require "rails_helper"

describe Competition do
  it "requires a name" do
    competition = Competition.new(name: nil)
    expect(competition.valid?).to be false
  end
end