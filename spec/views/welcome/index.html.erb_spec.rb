require 'rails_helper'

describe 'welcome/index' do
  let(:competition) { double(Competition) }

  context 'a competition exists' do
    it 'renders a list containing the competition' do
      expect(competition).to receive(:name).twice.and_return('My Competition')
      expect(competition).to receive(:id).and_return(32)
      assign(:competitions, [competition])
      render
    end
  end

  context 'no competition exists' do
    it 'renders an empty list' do
      assign(:competitions, [])
      render
    end
  end
end
