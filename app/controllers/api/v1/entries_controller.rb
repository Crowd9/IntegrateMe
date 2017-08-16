class Api::V1::EntriesController < ApplicationController

  # POST /api/v1/entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      MailchimpService.new(mailchimp_api_key).subscribe(@entry, mailchimp_list_id)
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

    def mailchimp_api_key
      @entry.competition.settings(:mailchimp).api_key.present? ? @entry.competition.settings(:mailchimp).api_key : Rails.application.secrets.mailchimp[:api_key]
    end

    def mailchimp_list_id
      @entry.competition.settings(:mailchimp).list_id.present? ? @entry.competition.settings(:mailchimp).list_id : Rails.application.secrets.mailchimp[:api_key]
    end
end
