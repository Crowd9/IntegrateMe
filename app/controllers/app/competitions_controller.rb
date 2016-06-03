module App
  class CompetitionsController < BaseController
    def entrant_page
      @competition = Competition.find(params[:competition_id])
    end

    def show
      # TODO: add authentication
      @competition = Competition.find(params[:id])
    end
  end
end
