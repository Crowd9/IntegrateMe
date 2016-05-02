class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:edit, :update, :destroy, :entrant_page]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = current_user.campaigns.all
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = Campaign.find(params[:id])
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = current_user.campaigns.new(campaign_params)
    if @campaign.save
      render json: {success: true}
    else
      render json: { errors: @campaign.errors, success: false }
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    # respond_to do |format|
    if @campaign.update(campaign_params)
      render json: {success: true}
    else
      render json: { errors: @campaign.errors, success: false }
    end
    # end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def entrant_page
    @entry = Entry.new(competition: @campaign.competition)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:list_id, :subject_line, :title, :from_name, :reply_to, :type, :api_key, :user_id)
    end
end
