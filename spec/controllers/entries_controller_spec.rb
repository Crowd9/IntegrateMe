require 'rails_helper'

describe EntriesController do

  let(:entry) { double(Entry) }
  let(:mailchimp) { double(MailChimpSender) }

  let(:entry_data) { {competition_id: '23', name: 'Jane Doe', email: 'jdoe@example.org'} }

  context 'create' do
    it 'submits successfully, MailChimp send works' do
      expect(entry).to receive(:save).and_return(true)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(mailchimp).to receive(:subscribe).and_return(nil)
      expect(MailChimpSender).to receive(:new).
        with(entry: entry, list_id: INTEGRATEMEINFO_LIST_ID).and_return(mailchimp)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: true, mail_chimp_delayed: false}.to_json)
    end

    it 'submits successfully with an extra parameter, MailChimp send works' do
      expect(entry).to receive(:save).and_return(true)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(mailchimp).to receive(:subscribe).and_return(nil)
      expect(MailChimpSender).to receive(:new).
        with(entry: entry, list_id: INTEGRATEMEINFO_LIST_ID).and_return(mailchimp)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: true, mail_chimp_delayed: false}.to_json)
    end

    it 'submits successfully, but MailChimp send fails' do
      expect(entry).to receive(:save).and_return(true)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(mailchimp).to receive(:subscribe).and_return("banana")
      expect(MailChimpSender).to receive(:new).
        with(entry: entry, list_id: INTEGRATEMEINFO_LIST_ID).and_return(mailchimp)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: true, mail_chimp_delayed: true}.to_json)
    end

    it 'fails to submit' do
      errors = double(ActiveModel::Errors)
      expect(errors).to receive(:as_json).and_return(['err'])

      expect(entry).to receive(:save).and_return(false)
      expect(entry).to receive(:errors).and_return(errors)
      expect(Entry).to receive(:new).with(entry_data).and_return(entry)

      expect(MailChimpSender).not_to receive(:new)

      post :create, entry: entry_data
      expect(response.body).to be_json_eql({success: false, :errors => ['err']}.to_json)
    end
  end

end