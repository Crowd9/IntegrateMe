require 'rails_helper'

RSpec.describe "integrations/index", type: :view do
  let(:integrations) { FactoryGirl.build_stubbed_list(:integration, 2) }
  before do
    assign(:integrations, integrations)
    view.stubs(integrations: integrations.each(&:decorate))
  end

  it "renders a list of integrations" do
    render
    assert_select "tr>td", :text => integrations.first.api_key, count: 1
    assert_select "tr>td", :text => integrations.first.api_token, count: 1
    assert_select "tr>td", :text => integrations.first.name, count: 1
  end
end
