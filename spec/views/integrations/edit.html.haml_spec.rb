require 'rails_helper'

RSpec.describe "integrations/edit", type: :view do
  before(:each) do
    @integration = assign(:integration, FactoryGirl.build_stubbed(:integration))
  end

  it "renders the edit integration form" do
    render

    assert_select "form[action=?][method=?]", integration_path(@integration), "post" do

      assert_select "input#integration_api_key[name=?]", "integration[api_key]"

      assert_select "input#integration_api_token[name=?]", "integration[api_token]"

      assert_select "input#integration_name[name=?]", "integration[name]"

      assert_select "select#integration_type[name=?]", "integration[type]"
    end
  end
end
