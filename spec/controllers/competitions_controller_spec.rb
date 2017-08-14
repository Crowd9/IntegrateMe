require 'rails_helper'

describe CompetitionsController do
  describe "GET #entrant_page" do
    it "renders entrant page" do
      competition = create(:competition_email_only)
      get :entrant_page, slug: competition.slug
      response.should render_template :entrant_page
    end
  end
end
