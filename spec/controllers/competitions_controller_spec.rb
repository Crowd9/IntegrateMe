require 'rails_helper'

RSpec.describe CompetitionsController, type: :controller do
  let(:competition) { create :competition }

  describe '#entrant_page' do
    # Having a little trouble figuring this one out because of the permalink
    # putting this on hold
    xit 'should render the entrant_page' do
    end
  end
end
