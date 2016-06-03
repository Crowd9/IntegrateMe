require 'rails_helper'

describe CustomUrlHelpers do
  describe '#competition_entrant_path' do
    it 'should create permalinks for competitions' do
      competition = create(:competition, name: 'My Competition!')
      expect(helper.competition_entrant_path(competition)).to eq("/#{competition.id}/my-competition")
    end
  end
end
