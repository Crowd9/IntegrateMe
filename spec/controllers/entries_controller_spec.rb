require 'rails_helper'

RSpec.describe EntriesController, type: :controller do

  describe "POST #create" do
    it "saves the new entry in the database" do
      attrs = build(:entry).attributes
      expect{post :create, entry: attrs}.to change(Entry, :count).by(1)
    end
    it "enqueues the SubscribeUserToMailingListJob" do
      attrs = build(:entry).attributes
      post :create, entry: attrs
      expect(SubscribeUserToMailingListJob).to have_been_enqueued.with(global_id(Entry))
    end
  end
end
