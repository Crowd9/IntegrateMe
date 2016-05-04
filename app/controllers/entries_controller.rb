class EntriesController < ApplicationController

  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      subscribe_user_to_mailing_list(@entry)
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

    def subscribe_user_to_mailing_list(entry)
      SubscribeUserToMailingListJob.perform_later(entry)
    end
end
