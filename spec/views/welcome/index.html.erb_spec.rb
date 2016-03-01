require 'rails_helper'

describe 'welcome/index' do
  let(:competition) { double(Competition) }

  context 'a competition exists' do
    it 'renders a list containing the competition'
  end

  context 'no competition exists' do
    it 'renders an empty list'
  end
end
