class Api::V1::BaseController < ApplicationController
  layout false

  private

  def respond_json_errors(options = {})
    options[:status] ||= 500
    render :json => options, :status => options[:status]
  end

  def respond_json_results(results, options = {})
    json = {:results => as_json_results(results)}
    if results.respond_to?(:total_entries)
      json[:pagination] = pagination_json(results)
    end

    status = options[:status] || 200
    render :json => json, :status => status
  end

  def as_json_results(results, options = {})
    results.as_json(options)
  end

  def pagination_json(results)
    {
      :count => results.total_entries,
      :total_pages => results.total_pages,
      :current_page => results.current_page.to_i,
      :per_page => results.per_page
    }
  end

  def search_params
    params[:search] || {}
  end
end
