class Api::V1::EntriesController < Api::V1::BaseController

  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      respond_json_results(@entry)
    else
      respond_json_errors(:errors => @entry.errors)
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end
end
