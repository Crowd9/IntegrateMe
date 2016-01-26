class Api::V1::SettingsController < Api::V1::BaseController
  def index
    settings = Setting.search(search_params)

    # TODO: We don't need to show api key for now.
    respond_json_results(settings)
  end

  def create
    setting = Setting.where(:code => settings_params[:code]).first
    setting ||= Setting.new(settings_params)

    if setting.save
      respond_json_results(setting)
    else
      respond_json_errors(:errors => setting.errors)
    end
  end

  private

    def settings_params
      params.require(:setting).permit(:code).tap do |wl|
        wl[:raw] = params[:setting][:raw]
      end
    end
end
