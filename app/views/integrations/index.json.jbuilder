json.array!(@integrations) do |integration|
  json.extract! integration, :id, :api_key, :api_token, :name, :type, :created_at
  json.url integration_url(integration, format: :json)
end
