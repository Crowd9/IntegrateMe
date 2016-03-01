require 'rails_helper'

describe 'competitions/entrant_page' do
  let(:competition) { double(Competition) }
  let(:entry) { double(Entry) }

  it 'renders an entry form for a competition with name and email' do
    expect(competition).to receive('requires_entry_name?'.to_sym).and_return(true)
    expect(competition).to receive(:name).and_return('My Competition')
    expect(competition).to receive(:id).and_return(32)

    expect(entry).to receive(:competition).and_return(competition)
    assign(:entry, entry)

    render
  end

  it 'renders an entry form for a competition with email' do
    expect(competition).to receive('requires_entry_name?'.to_sym).and_return(false)
    expect(competition).to receive(:name).and_return('My Competition')
    expect(competition).to receive(:id).and_return(32)

    expect(entry).to receive(:competition).and_return(competition)
    assign(:entry, entry)

    render
  end
end
