require 'rails_helper'

describe Api::V1::CompetitionsController, :type => :controller do
  describe "GET index" do
    let!(:competitions) {FactoryGirl.create_list(:competition, rand(5))}

    it "should return settings in json" do
      get :index

      expect(response.status).to eql(200)
      expect(json["results"].length).to eql(Competition.count)
    end

    it "should return pagination info" do
      FactoryGirl.create_list(:competition, 6)
      per_page = 2
      get :index, :per_page => per_page

      expect(response.status).to eql(200)
      expect(json["pagination"]).to be_present
      expect(json["pagination"]["count"]).to eql(Competition.count)
      expect(json["pagination"]["total_pages"]).to eql((Competition.count.to_f/per_page).ceil)
      expect(json["pagination"]["per_page"]).to eql(per_page)
      expect(json["pagination"]["current_page"]).to eql(1)
    end


    it "should allow search setting" do
      relation = double(:relation)
      allow(Competition).to receive(:search).and_return(relation)
      allow(relation).to receive(:paginate).and_return([])
      expect(Competition).to receive(:search).with({})

      get :index
      expect(response.status).to eql(200)
    end
  end

  describe "GET show" do
    let(:competition) {FactoryGirl.create(:competition)}
    it "should return the specified competition" do
      get :show, :id => competition.id

      expect(response.status).to eql(200)
      expect(json["results"]).to be_present
      expect(json["results"]["id"]).to eql(competition.id)
    end
  end
end
