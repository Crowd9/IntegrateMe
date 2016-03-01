require 'rails_helper'

describe MailChimpSender do

  let(:entry) { double(Entry) }
  let(:list_id) { 'a_list_id' }

  let(:gibbon)  { double(Gibbon::Request) }
  let(:lists)   { double('lists') }
  let(:members) { double('members') }

  it "returns nil on success" do
    expect(members).to receive(:create)
    expect(lists).to receive(:members).with(no_args).and_return(members)
    expect(gibbon).to receive(:lists).with(list_id).and_return(lists)

    expect(entry).to receive(:name).and_return('Jane Doe')
    expect(entry).to receive(:email).and_return('jdoe@example.org')

    expect(Gibbon::Request).to receive(:new).and_return(gibbon)
    sender = MailChimpSender.new(entry: entry, list_id: list_id)
    result = sender.subscribe
    expect(result).to be_nil
  end

  it "returns a string with an error message on failure" do
    expect(members).to receive(:create).and_raise(Gibbon::MailChimpError.new('err'))
    expect(lists).to receive(:members).with(no_args).and_return(members)
    expect(gibbon).to receive(:lists).with(list_id).and_return(lists)
    expect(Gibbon::Request).to receive(:new).and_return(gibbon)

    expect(entry).to receive(:name).and_return('Jane Doe')
    expect(entry).to receive(:email).and_return('jdoe@example.org')

    sender = MailChimpSender.new(entry: entry, list_id: list_id)
    result = sender.subscribe
    expect(result).to be_a(String)
    expect(result).to match(/^err /)
  end

end