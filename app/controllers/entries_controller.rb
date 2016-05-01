class EntriesController < ApplicationController
  before_action :set_campaign, only: [:edit, :update, :create, :new]
  before_action :set_entry, only: [:edit, :update]

  # GET /entries/new
  def new
    @entry = @campaign.entries.new
  end

  # POST /entries.json
  def create
    @entry = @campaign.entries.new(entry_params)

    if @entry.save
      render json: {success: true}
    else
      render json: {success: false, errors: @entry.errors}
    end
  end

  # GET /campaigns/1/entries/1/edit
  def edit
  end

  # PATCH/PUT /campaigns/1/entries/1
  # PATCH/PUT /campaigns/1/entries/1.json
  def update
    # respond_to do |format|
      if @entry.update(entry_params)
        render json: {success: true}
        # format.html { redirect_to @entry, notice: 'Campaign was successfully updated.' }
        # format.json { render :show, status: :ok, location: @entry }
      else
        render json: {success: false, errors: @entry.errors}
        # format.html { render :edit }
        # format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    # end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = current_user.campaigns.find_by(id: params[:campaign_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = @campaign.entries.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email, :id, :campaign_id)
    end
end
