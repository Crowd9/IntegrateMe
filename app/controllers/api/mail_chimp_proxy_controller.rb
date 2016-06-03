module Api
  class MailChimpProxyController < BaseController
    def lists
      result = MailChimpAdapter::GibbonAdapter.new(
        api_key: params[:mail_chimp_api_key],
        debug: Rails.env.development?
      ).all_lists
      render json: result, status: 200
    rescue MailChimpAdapter::MailChimpError => e
      render json: { success: false, error_message: e.message }, status: 400
    end
  end
end
