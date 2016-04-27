require "rails_helper"

describe Competition do
  it "should require a name" do
    expect { Competition.create!(name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe ".search" do
    let!(:competitions) { FactoryGirl.create_list(:competition, rand(10)) }

    it "should return all competition" do
      expect(Competition.search({}).count).to eql(Competition.count)
    end
  end
end
