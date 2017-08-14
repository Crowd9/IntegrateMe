class Api::V1::EntriesController < ApplicationController

  # POST /api/v1/entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      MailchimpService.new.subscribe(@entry)
      render json: {success: true, status: 200}
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
