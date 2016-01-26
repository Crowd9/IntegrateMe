class Api::V1::CompetitionsController < Api::V1::BaseController
  def index
    competitions = Competition.search(search_params).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 20)
    respond_json_results(competitions)
  end

  def show
    respond_json_results(competition)
  end

  private

    def competition
      @competition ||= Competition.find(params[:id])
    end
end
