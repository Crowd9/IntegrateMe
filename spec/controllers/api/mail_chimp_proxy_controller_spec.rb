require 'rails_helper'

describe Api::MailChimpProxyController do
  let(:response_json) { JSON.parse(response.body) }
  describe 'GET /list' do
    before { allow_any_instance_of(MailChimpAdapter::GibbonAdapter).to receive(:all_lists) }

    context 'when api request fails' do
      before do
        allow_any_instance_of(MailChimpAdapter::GibbonAdapter).to receive(:all_lists)
          .and_raise(MailChimpAdapter::MailChimpError, 'test error')
      end

      it 'responds with status=400 and response contains error message' do
        get :lists, api_key: 'test-api-key'
        expect(response).to have_http_status(400)
        expect(response_json).to match(a_hash_including('error_message' => 'test error'))
      end
    end

    context 'when api request is successful' do
      before do
        allow_any_instance_of(MailChimpAdapter::GibbonAdapter).to receive(:all_lists)
          .and_return('some' => { 'shape' => { 'of' => 'response' } })
      end

      it "responds with status=200 and response contains mailchimp's response as is" do
        get :lists, api_key: 'test-api-key'
        expect(response).to have_http_status(200)
        expect(response_json).to match('some' => { 'shape' => { 'of' => 'response' } })
      end
    end
  end
end
