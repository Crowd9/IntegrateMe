require 'rails_helper'

RSpec.describe "integrations/show", type: :view do
  describe 'show' do
    before do
      @integration = assign(:integration, FactoryGirl.build_stubbed(:mailchimp))
      @integration.stubs(connect: true)
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/#{@integration.api_key}/)
      expect(rendered).to match(/#{@integration.api_token}/)
      expect(rendered).to match(/#{@integration.name}/)
      expect(rendered).to match(/#{@integration.type}/)
    end
  end
end
