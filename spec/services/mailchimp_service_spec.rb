require 'rails_helper'

RSpec.describe MailchimpService do
  WebMock.allow_net_connect!

  # As requested in the README.md file, this spec is actually sending data to mailchimp
  describe '#subscribe' do
    it 'should subscribe with first and last name' do
      name = Faker::Name.name
      email = Faker::Internet.email

      request = MailchimpService.new.subscribe(name, email)

      expect(request.body['email_address']).to eq(email)
      expect(request.body['status']).to eq('subscribed')
      expect(request.body['merge_fields']['FNAME']).to eq(name.split(' ', 2)[0])
      expect(request.body['merge_fields']['LNAME']).to eq(name.split(' ', 2)[1])
    end

    it 'should subscribe without first and last name' do
      email = Faker::Internet.email

      request = MailchimpService.new.subscribe(nil, email)

      expect(request.body['email_address']).to eq(email)
      expect(request.body['status']).to eq('subscribed')
    end
  end
end

