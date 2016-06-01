require 'rails_helper'

describe ResyncEntry do
  let(:test_mail_chimp_adapter) { double(:test_mail_chimp_adapter, add_member_to_list: nil) }
  subject { ResyncEntry.new(mail_chimp_adapter: test_mail_chimp_adapter) }
  let(:entry) { create(:entry) }

  context 'when synchronization to MailChimp is successful' do
    it 'switches entry sync_status to "synced"' do
      result = subject.call(entry)
      expect(result[:success]).to be(true)
      expect(entry.reload.sync_status).to eq('synced')
    end
  end

  context 'when synchronization to MailChimp fails' do
    it 'switches entry sync_status to "failed"' do
      allow(test_mail_chimp_adapter).to receive(:add_member_to_list).and_raise(MailChimpAdapter::MailChimpError)
      result = subject.call(entry)
      expect(result[:success]).to be(false)
      expect(entry.reload.sync_status).to eq('failed')
    end
  end
end
