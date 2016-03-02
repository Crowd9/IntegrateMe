require 'rails_helper'

describe EntriesController do

  let(:entry) { double(Entry) }
  let(:entry_id) { 3 }
  let(:list_id) { 'a_list_id' }

  let(:entry_data) { {competition_id: '23', name: 'Jane Doe', email: 'jdoe@example.org'} }

  context 'create' do
    it 'submits successfully' do
      allow(ENV).to receive(:[]).with("INTEGRATEMEINFO_LIST_ID").and_return(list_id)

      expect(entry).to receive(:save).and_return(true)
      expect(entry).to receive(:id).and_return(entry_id)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(SubscribeUserInMailChimpJob).to receive(:perform_later).
        with(entry_id, list_id)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: true}.to_json)
    end

    it 'fails to submit' do
      errors = double(ActiveModel::Errors)
      expect(errors).to receive(:as_json).and_return(['err'])

      expect(entry).to receive(:save).and_return(false)
      expect(entry).to receive(:errors).and_return(errors)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(SubscribeUserInMailChimpJob).not_to receive(:perform_later)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: false, errors: ['err']}.to_json)
    end
  end

end