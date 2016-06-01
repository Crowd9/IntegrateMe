class CompetitionsController < ApplicationController
  def entrant_page
    @entry = Entry.new(competition: Competition.find(params[:competition_id]))
  end

  def show
    # TODO: add authentication
    @competition = Competition.find(params[:id])
  end
end
