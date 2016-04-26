class EntriesController < ApplicationController

  # POST /entries.json
  def create
    campaign = Campaign.find params[:campaign_id]
    @entry = Entry.new(entry_params.merge({api_key: campaign.api_key}))

    if @entry.save
      render json: {success: true}
    else
      render json: {success: false, errors: @entry.errors}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end
end
