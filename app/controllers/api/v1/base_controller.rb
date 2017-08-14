class API::V1::BaseController < ApplicationController

  before_action :resource_find, only: [ :show, :update, :destroy ]
  before_action :build_resource, only: [ :create ]

  def index
    @resources = resource_class_name.all
    render json: @resources, root: false
  end

  def show
    render json: {success: true, data: @entity, status: 200}
  end

  def create
    if @entity.save
      render json: @entity
    else
      render json: {success: false, errors: @entity.errors}, status: 422
    end
  end

  def update
    if @entity.update(permitted_params)
      render json: @entity
    else
      render json: {success: false, errors: @entity.errors}, status: 422
    end
  end

  def destroy
    @entity.destroy
    render json: {success: true}, status: 200
  end

  private

    def resource_find
      @entity = resource_class_name.find(params[:id])
    end

    def build_resource
      @entity = resource_class_name.new(permitted_params)
    end

    def permitted_params(parameters = params)
      parameters.permit(self.class::PERMITTED_ATTRIBUTES)
    end

end
