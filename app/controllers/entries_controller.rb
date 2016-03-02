class EntriesController < ApplicationController

  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    unless @entry.save
      render json: {success: false, errors: @entry.errors}
      return
    end

    SubscribeUserInMailChimpJob.perform_later(@entry.id, ENV['INTEGRATEMEINFO_LIST_ID'])
    render json: {success: true}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end
end
