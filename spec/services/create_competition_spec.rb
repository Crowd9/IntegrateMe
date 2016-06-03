require 'rails_helper'

describe CreateCompetition do
  let(:valid_params) { attributes_for(:competition) }
  subject { CreateCompetition.new(mail_chimp_adapter: MailChimpAdapter::TestAdapter) }

  it 'creates competition with a MailChimp list assigned' do
    result = subject.call(valid_params)
    expect(result[:success]).to be(true)
    expect(result[:competition]).to be_instance_of(Competition)
    expect(result[:competition].mail_chimp_api_key).to be
    expect(result[:competition].mail_chimp_list_id).to be
  end

  context 'when name or runner_email is not provided' do
    it 'returns failure with corresponding validation errors' do
      result = subject.call(requires_entry_name: false)
      expect(result[:success]).to be(false)
      expect(result[:errors][:name]).not_to be_empty
      expect(result[:errors][:runner_email]).not_to be_empty
    end
  end

  context 'when mail chimp list id validation fails' do
    before do
      allow_any_instance_of(MailChimpAdapter::TestAdapter).to receive(:find_list)
        .and_raise(MailChimpAdapter::MailChimpError, 'test error')
    end

    it 'returns failure with error on mail_chimp_list_id' do
      result = subject.call(valid_params)
      expect(result[:success]).to be(false)
      expect(result[:errors][:mail_chimp_list_id]).to include('test error')
    end
  end
end
