require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  let(:contacts) { FactoryGirl.create_list(:contact, 2) }

  before(:each) do
    assign(:contacts, contacts)
    view.stubs(contacts: contacts.each(&:decorate))
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", text: contacts.first.name.to_s, count: 1
    assert_select "tr>td", text: contacts.last.email.to_s, count: 1
  end
end
