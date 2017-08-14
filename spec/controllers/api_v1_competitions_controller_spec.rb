require 'rails_helper'

describe Api::V1::CompetitionsController do
  describe "GET #show" do
    it "renders competition json" do
      competition = create(:competition_email_only)
      get :show, id: competition.id
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]).to eq(JSON.parse(competition.to_json))
    end
  end
end
