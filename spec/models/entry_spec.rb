require 'rails_helper'

RSpec.describe Entry, type: :model do

  let(:competition) { FactoryGirl.create(:competition) }
  let(:entry) { competition.entries.create! name: Faker::Name.name, email: Faker::Internet.email }


  describe 'email' do

    subject { entry }

    it { should validate_presence_of :email }

    # it { should validate_uniqueness_of(:email) }

    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        entry.email = invalid_address
        expect(entry).not_to be_valid
      end
    end

  end

  describe 'name' do
    subject { entry }

    context 'required' do
      it { should validate_presence_of :name }
    end

    # context 'not required' do
    #   it 'should not validate presence of name' do
    #   end
    # end

  end


  describe 'subscribe_user' do

    it "queues job when a entry is created" do
      expect do
        FactoryGirl.create(:entry)
      end.to change{Delayed::Job.count}.by(1)
    end

    it 'should create add user over mailchimp api' do
      gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
      before_create_count = gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.retrieve['total_items']
      FactoryGirl.create(:entry)
      Delayed::Worker.new.work_off
      after_create_count = gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.retrieve['total_items']
      expect(after_create_count).to eq(before_create_count+1)
    end

  end


end
