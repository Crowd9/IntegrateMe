module Api
  class CompetitionsController < BaseController
    def create
      # TODO: add authentication
      result = CreateCompetition.new(
        mail_chimp_adapter: MailChimpAdapter::GibbonAdapter
      ).call(competition_params)
      if result[:success]
        render json: result[:competition], serializer: CompetitionSerializer
      else
        render json: result, status: 400
      end
    end

    def competition_params
      params.require(:competition).permit(
        :name,
        :requires_entry_name,
        :runner_email,
        :mail_chimp_api_key,
        :mail_chimp_list_id
      )
    end
  end
end
