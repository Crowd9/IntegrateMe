require 'rails_helper'

RSpec.describe "integrations/new", type: :view do
  before(:each) do
    @integration = assign(:integration, FactoryGirl.build(:integration))
  end

  it "renders new integration form" do
    render

    assert_select "form[action=?][method=?]", integrations_path, "post" do

      assert_select "input#integration_api_key[name=?]", "integration[api_key]"

      assert_select "input#integration_api_token[name=?]", "integration[api_token]"

      assert_select "input#integration_name[name=?]", "integration[name]"

      assert_select "select#integration_type[name=?]", "integration[type]"
    end
  end
end
