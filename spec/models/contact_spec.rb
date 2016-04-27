require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryGirl.build_stubbed(:contact, name: 'Test User') }
  let(:integration) { FactoryGirl.build_stubbed(:integration) }

  describe '#queue_integrations' do
    before do
      Integration.stubs(all: [integration])
    end
   
    it 'integration expects queue' do
      expect(integration).to receive(:queue).with(contact)
      contact.queue_integrations
    end
  end

  describe '#first_name' do
    subject { contact.first_name }
    it { should eq 'Test' }
  end

  describe '#last_name' do
    subject { contact.last_name }
    it { should eq 'User' }

    context 'only name' do
      before do
        contact.name = 'Test'
      end
      it { should be_nil }
    end
  end
end
