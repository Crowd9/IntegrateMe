require 'rails_helper'

describe MailChimp do
  let(:entry) {
    OpenStruct.new(email: 'test@email.com', name: 'Alex', competition_id: 1)
  }

  let(:gibbon) { double('Gibbon') }

  subject { MailChimp.new }

  describe "#subscribe_to_mail_chimp" do
    it "subscribes to mail chimp" do
      allow(gibbon).to receive(:timeout=)
      allow(gibbon).to receive(:open_timeout=)
      allow(gibbon).to receive(:lists).with(MailChimp::LIST_ID).and_return(gibbon)
      allow(gibbon).to receive(:members).and_return(gibbon)
      allow(gibbon).to receive(:create).with(instance_of(Hash))
      allow(Gibbon::Request).to receive(:new).with(hash_including(api_key: MailChimp::API_KEY, debug: false)) { gibbon }

      expect(subject).to receive(:fetch_latest_entry).with(entry)
      subject.subscribe_to_mail_chimp(entry)
    end
  end
end
