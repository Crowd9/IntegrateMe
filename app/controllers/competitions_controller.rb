class CompetitionsController < ApplicationController
  def entrant_page
    competition = Competition.find_by_id(params[:competition_id])
    if competition.nil?
      render :file => "#{Rails.root}/public/404.html", :status => 404
      return
    end

    @entry = Entry.new(competition: competition)
  end
end