class CompetitionsController < ApplicationController
  # Callbacks
  before_action :find_competition, only: :entrant_page

  # GET /competitions/:slug/entrant
  def entrant_page
    @entry = Entry.new(competition: @competition)
  end

  private
    def find_competition
      begin
        @competition = Competition.friendly.find(params[:slug])
      rescue
        flash[:error] = "Competition doesn't exist."
        redirect_to root_path
      end
    end
end
