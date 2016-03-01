require 'rails_helper'

describe CompetitionsController do

  context 'get' do
    let(:entry) { double(Entry) }
    let(:competition) { double(Competition, id: 23) }

    it 'shows an entry page' do
      expect(Entry).to receive(:new).with(:competition => competition).and_return(entry)
      expect(Competition).to receive(:find_by_id).with(competition.id.to_s).
        and_return(competition)

      get :entrant_page, competition_id: competition.id.to_s, permalink: 'my_competition'
      expect(response).to be_success
      expect(response).to render_template('entrant_page')
      expect(assigns[:entry]).to eq(entry)
    end

    it 'returns 404 if competition not found' do
      expect(Entry).not_to receive(:new)
      expect(Competition).to receive(:find_by_id).with(competition.id.to_s).
        and_return(nil)

      get :entrant_page, competition_id: competition.id.to_s, permalink: 'my_competition'
      expect(response).to be_not_found
      expect(assigns[:entry]).to be_nil
    end

  end

end