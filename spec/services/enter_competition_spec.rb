require 'rails_helper'

class TestMailChimpAdapter
  def all_list; end
  def find_list(_list_id); end
  def add_member_to_list(_list_id, email:, name:); end
end

describe EnterCompetition do
  let(:test_mail_chimp_adapter) { TestMailChimpAdapter.new }
  subject { EnterCompetition.new(mail_chimp_adapter: test_mail_chimp_adapter) }

  context 'when user enters competition which doesn\'t exists' do
    it 'fails with an error on competition_id' do
      result = subject.call(competition_id: 0)
      expect(result[:success]).to be_falsey
      expect(result[:errors].messages[:competition]).not_to be_empty
    end
  end

  context 'when user enters competition that requires name without one' do
    let!(:competition) { create(:competition, requires_entry_name: true) }
    it 'fails with an error on name' do
      result = subject.call(competition_id: competition.id, email: 'luke@example.com')
      expect(result[:success]).to be_falsey
      expect(result[:errors].messages[:name]).not_to be_empty
    end
  end

  context 'when user enters competition with valid input' do
    let!(:competition) { create(:competition, requires_entry_name: false) }

    it 'creates entry' do
      result = subject.call(competition_id: competition.id, email: 'luke@example.com')
      expect(result[:success]).to be_truthy
    end

    it 'synchronizes entry to MailChimp' do
      allow(test_mail_chimp_adapter).to receive(:add_member_to_list)
      subject.call(competition_id: competition.id, email: 'luke@example.com')
      expect(test_mail_chimp_adapter).to have_received(:add_member_to_list)
        .with(competition.mail_chimp_list_id, email: 'luke@example.com', name: nil)
    end

    it 'switches entry sync_status to "synced"' do
      subject.call(competition_id: competition.id, email: 'luke@example.com')
      expect(Entry.find_by(email: 'luke@example.com').sync_status).to eq('synced')
    end

    context 'when synchronization to MailChimp fails' do
      it 'switches entry sync_status to "failed"' do
        allow(test_mail_chimp_adapter).to receive(:add_member_to_list).and_raise(MailChimpAdapter::MailChimpError)
        result = subject.call(competition_id: competition.id, email: 'luke@example.com')
        expect(result[:success]).to be_truthy
        expect(Entry.find_by(email: 'luke@example.com').sync_status).to eq('failed')
      end

      it 'sends failure email to competition runner' do
        allow(test_mail_chimp_adapter).to receive(:add_member_to_list)
          .and_raise(MailChimpAdapter::MailChimpError, 'test message')
        allow(SystemMailer).to receive(:notify_failed_synchronization)
        subject.call(competition_id: competition.id, email: 'luke@example.com')
        expect(SystemMailer).to have_received(:notify_failed_synchronization)
          .with(competition.runner_email, 'test message', anything)
      end
    end
  end
end
