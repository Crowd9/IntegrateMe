class IntegrationsController < ApplicationController
  before_action :set_integration, only: [:show, :edit, :update, :destroy]
  
  responders :flash
  respond_to :html, :json

  #
  # Decorates integration
  #
  decorates_assigned :integrations, :integration

  # GET /integrations
  def index
    @integrations = Integration.all
    respond_with(@integrations)
  end

  # GET /integrations/1
  def show
    respond_with(@integration)
  end

  # GET /integrations/new
  def new
    @integration = Integration.new
    respond_with(@integration)
  end

  # GET /integrations/1/edit
  def edit
  end

  # POST /integrations
  def create
    @integration = Integration.new(integration_params)
    @integration.save
    respond_with(@integration, location: -> { integration_path(@integration) })
  end

  # PATCH/PUT /integrations/1
  def update
    @integration.update(integration_params)
    respond_with(@integration, location: -> { integration_path(@integration) })
  end

  # DELETE /integrations/1
  def destroy
    @integration.destroy
    respond_with(@integration, location: -> { integrations_path })
  end

  private
    #
    # Finds and assigns the integration
    #
    # @returns [Integration] integration
    def set_integration
      @integration = Integration.find(params[:id])
    end

    #
    # Integration params
    #
    def integration_params
      params.require(:integration).permit(:api_key, :api_token, :name, :type)
    end
end
