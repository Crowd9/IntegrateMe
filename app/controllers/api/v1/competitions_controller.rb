class Api::V1::CompetitionsController < API::V1::BaseController

  private
  
    def resource_class_name
      Competition
    end
end
