require "rails_helper"

describe CompetitionsHelper do
  describe "#competition_entrant_page" do
    it "creates permalinks for competitions" do
      competition = double(Competition)
      expect(competition).to receive(:id).and_return(99)
      expect(competition).to receive(:name).and_return('My Competition!')

      page_link = helper.competition_entrant_page(competition)
      expect(page_link).to eq("/99/my-competition")
     end
  end
end