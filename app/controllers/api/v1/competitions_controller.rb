class Api::V1::CompetitionsController < API::V1::BaseController
  before_action :resource_find, only: [ :show, :update, :destroy, :subscribe_to_mailchimp_list ]

  # GET /api/v1/competitions/:id/mailchimp_lists
  def mailchimp_lists
    result = MailchimpService.new(params[:api_key]).get_lists
    if result.kind_of?(Hash)
      render json: {success: true, data: result, status: 200}
    else
      render json: {success: false, errors: result}
    end
  end

  # POST /api/v1/competitions/:id/subscribe_to_mailchimp_list
  def subscribe_to_mailchimp_list
    @entity.settings(:mailchimp).update_attributes! :api_key => params[:api_key]
    @entity.settings(:mailchimp).update_attributes! :list_id => params[:list_id]

    if params[:assign_all_emails_to_list] == true
      assign_all_emails_to_list
    end

    render json: {success: true, status: 200}
  end

  private

    def resource_class_name
      Competition
    end

    def assign_all_emails_to_list
      api_key = @entity.settings(:mailchimp).api_key
      list_id = @entity.settings(:mailchimp).list_id
      @entity.entries.each do |entry|
        MailchimpService.new(api_key).subscribe(entry, list_id)
      end
    end
end
