require 'rails_helper'

describe Api::V1::EntriesController, :type => :controller do
  describe "POST create" do
    let(:competition) {FactoryGirl.create(:competition)}
    context "with valid attributes" do
      it "should create entry with valid attributes" do
        attrs = FactoryGirl.attributes_for(:entry)
        attrs[:competition_id] = competition.id
        expect {
          post :create, :entry => attrs
        }.to change{Entry.count}.by(1)

        expect(response.status).to eql(200)
        expect(json["results"]).to be_present
        expect(json["results"]["competition_id"]).to eql(attrs[:competition_id])
      end
    end

    context "with invalid atrributes" do
      it "should return error if email is missing" do
        attrs = FactoryGirl.attributes_for(:entry)
        attrs[:email] = nil
        attrs[:competition_id] = competition.id

        expect {
          post :create, :entry => attrs
        }.to change{Entry.count}.by(0)

        expect(response.status).to eql(500)
        expect(json["errors"]).to be_present
        expect(json["errors"]["email"]).to be_present
      end

      it "should return error if email is duplicated of the same competition" do
        entry = FactoryGirl.create(:entry)
        attrs = entry.attributes
        attrs.delete("id")

        expect {
          post :create, :entry => attrs
        }.to change{Entry.count}.by(0)

        expect(response.status).to eql(500)
        expect(json["errors"]).to be_present
        expect(json["errors"]["email"]).to be_present
      end
    end
  end
end
