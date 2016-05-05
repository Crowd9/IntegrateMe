json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :list_id, :subject_line, :title, :from_name, :reply_to, :type, :api_key, :user_id
  json.url campaign_url(campaign, format: :json)
end
