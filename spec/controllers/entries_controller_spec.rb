require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:competition_with_name) { create :competition, requires_entry_name: true }
  let(:competition_without_name) { create :competition, requires_entry_name: false }
  let(:entry_with_name) { build :entry, email: 'email@email.com', name: 'Andre Macedo', competition: competition_with_name }

  # For the controller testing I decided to use webmock to simulate mailchimp API requests
  # The real requests are tested in the services spec
  describe '#create' do

    before :each do
      stub_request(:post, "https://us17.api.mailchimp.com/3.0/lists/0750b806bd/members").
        with(body: {
          email_address: 'email@email.com', 
          status: 'subscribed',
          merge_fields: { FNAME: 'Andre', LNAME: 'Macedo' }
        }).
      to_return(status: 200)

      stub_request(:post, "https://us17.api.mailchimp.com/3.0/lists/0750b806bd/members").
        with(body: {
          email_address: 'email@email.com', 
          status: 'subscribed'
        }).
      to_return(status: 200)
    end
    
    it 'should create a valid entry in a competition that requires name' do
      post :create, {
        entry: {
          name: entry_with_name.name,
          email: entry_with_name.email,
          competition_id: competition_with_name.id
        }
      }

      expect(response).to have_http_status(:ok)
      expect(Entry.count).to eq(1)
      expect(Entry.first.name).to eq(entry_with_name.name)
      expect(Entry.first.email).to eq(entry_with_name.email)
    end

    it 'should create a valid entry in a competition that does not require name' do
      post :create, {
        entry: {
          email: entry_with_name.email,
          competition_id: competition_without_name.id
        }
      }

      expect(response).to have_http_status(:ok)
      expect(Entry.count).to eq(1)
      expect(Entry.first.email).to eq(entry_with_name.email)
    end

    it 'should not create an entry without name in a competition that requires name' do
      post :create, {
        entry: {
          email: entry_with_name.email,
          competition_id: competition_with_name.id
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']['name'].first).to eq('can\'t be blank')
      expect(Entry.count).to eq(0)
    end

    it 'should not create a valid entry when there is already a duplicate email' do
      entry_with_name.save

      post :create, {
        entry: {
          name: entry_with_name.name,
          email: entry_with_name.email,
          competition_id: competition_with_name.id
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']['email'].first).to eq('has already entered this competition')
      expect(Entry.count).to eq(1)
    end
  end
end
