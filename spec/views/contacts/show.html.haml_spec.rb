require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :name => Faker::Name.name ,
      :email => Faker::Internet.email
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@contact.name}/)
    expect(rendered).to match(/#{@contact.email}/)
  end
end
