class CompetitionsController < ApplicationController
  def entrant_page
    @campaign = current_user.campaigns.find_by id: params[:campaign_id]
    @entry = @campaign.entries.new(competition: Competition.find(params[:competition_id]))
  end
end