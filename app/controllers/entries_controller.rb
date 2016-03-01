class EntriesController < ApplicationController

  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    unless @entry.save
      render json: {success: false, errors: @entry.errors}
      return
    end

    mail_chimp_sender = MailChimpSender.new(entry: @entry,
      list_id: INTEGRATEMEINFO_LIST_ID)
    mail_chimp_err = mail_chimp_sender.subscribe
    render json: {success: true, mail_chimp_delayed: !mail_chimp_err.nil?}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end
end
