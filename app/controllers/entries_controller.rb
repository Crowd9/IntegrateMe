class EntriesController < ApplicationController
  # POST /entries.json
  def create
    result = EnterCompetition.new(mail_chimp_adapter: gibon_adapter).call(entry_params)
    render json: result, status: result[:success] ? 200 : 400
  end

  def resync
    # TODO: add authentication
    result = ResyncEntry.new(mail_chimp_adapter: gibon_adapter).call(Entry.find(params[:id]))
    render json: result, status: result[:success] ? 200 : 400
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:competition_id, :name, :email)
  end

  def gibon_adapter
    MailChimpAdapter::GibonAdapter.new(
      api_key: Rails.application.config.x.mail_chimp['api_key'],
      debug: Rails.env.development?
    )
  end
end
