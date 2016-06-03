require 'rails_helper'

describe ResyncEntry do
  subject { ResyncEntry.new(mail_chimp_adapter: MailChimpAdapter::TestAdapter) }
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
      allow_any_instance_of(MailChimpAdapter::TestAdapter).to receive(:add_member_to_list)
        .and_raise(MailChimpAdapter::MailChimpError)
      result = subject.call(entry)
      expect(result[:success]).to be(false)
      expect(entry.reload.sync_status).to eq('failed')
    end
  end
end
