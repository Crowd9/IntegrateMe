require 'rails_helper'

RSpec.describe SubscribeUserInMailChimpJob do
  let(:entry) { double(Entry, id: 8) }
  let(:list_id) { 'a_list_id' }

  let(:gibbon)  { double(Gibbon::Request) }
  let(:lists)   { double('lists') }
  let(:members) { double('members') }

  it "submits successfully" do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(nil)
    allow(ENV).to receive(:[]).with("MAILCHIMP_API_KEY").and_return("abcdefghij")

    expect(members).to receive(:create)
    expect(lists).to receive(:members).with(no_args).and_return(members)
    expect(gibbon).to receive(:lists).with(list_id).and_return(lists)

    expect(entry).to receive(:name).twice.and_return('Jane Doe')
    expect(entry).to receive(:email).and_return('jdoe@example.org')
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    expect(entry).to receive(:update_attribute).with(:mail_chimp_subscribed, true)

    expect(Gibbon::Request).to receive(:new).and_return(gibbon)
    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end

  it "fails to submit" do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(nil)
    allow(ENV).to receive(:[]).with("MAILCHIMP_API_KEY").and_return("abcdefghij")

    expect(members).to receive(:create).and_raise(Gibbon::MailChimpError.new('err'))
    expect(lists).to receive(:members).with(no_args).and_return(members)
    expect(gibbon).to receive(:lists).with(list_id).and_return(lists)
    expect(Gibbon::Request).to receive(:new).and_return(gibbon)

    expect(entry).to receive(:name).twice.and_return('Jane Doe')
    expect(entry).to receive(:email).and_return('jdoe@example.org')
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    expect(entry).to receive(:update_attribute).with(:mail_chimp_subscribed, false)

    expect(Rails.logger).to receive(:error).
      with(/^MailChimp subscribe failed, Gibbon error: err/)

    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end

  it 'fails if the api key is not set' do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(nil)
    allow(ENV).to receive(:[]).with("MAILCHIMP_API_KEY").and_return(nil)

    expect(Gibbon::Request).not_to receive(:new)

    expect(entry).to receive(:update_attribute).with(:mail_chimp_subscribed, false)
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    expect(Rails.logger).to receive(:error).
      with("MailChimp subscribe failed: ENV['MAILCHIMP_API_KEY'] is not set")

    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end

  it 'fails if the list id is not set' do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(nil)
    allow(ENV).to receive(:[]).with("MAILCHIMP_API_KEY").and_return("abcdefghij")

    expect(Gibbon::Request).not_to receive(:new)

    expect(entry).to receive(:update_attribute).with(:mail_chimp_subscribed, false)
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    expect(Rails.logger).to receive(:error).
      with("MailChimp subscribe failed: List id not provided")

    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, nil)
  end

  it "submits successfully if failed earlier" do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(false)
    allow(ENV).to receive(:[]).with("MAILCHIMP_API_KEY").and_return("abcdefghij")

    expect(members).to receive(:create)
    expect(lists).to receive(:members).with(no_args).and_return(members)
    expect(gibbon).to receive(:lists).with(list_id).and_return(lists)

    expect(entry).to receive(:name).twice.and_return('Jane Doe')
    expect(entry).to receive(:email).and_return('jdoe@example.org')
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    expect(entry).to receive(:update_attribute).with(:mail_chimp_subscribed, true)

    expect(Gibbon::Request).to receive(:new).and_return(gibbon)
    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end

  it 'does not try to submit again if already subscribed' do
    expect(entry).to receive(:mail_chimp_subscribed?).and_return(true)

    expect(Gibbon::Request).not_to receive(:new)
    expect(entry).not_to receive(:update_attribute)
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(entry)

    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end

  it 'does not try to submit if entry not found' do
    expect(Gibbon::Request).not_to receive(:new)
    expect(Entry).to receive(:find_by).with(id: entry.id).and_return(nil)

    subscriber = SubscribeUserInMailChimpJob.new
    subscriber.perform(entry.id, list_id)
  end
end
