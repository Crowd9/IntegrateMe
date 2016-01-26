settings_path="#{Rails.root}/config/settings/"
yml_files = Dir.glob("#{settings_path}*.yml")

if yml_files.present?
  APP_CONFIG = yml_files.inject({}) do |result, file_path|
    raw_config = ERB.new(File.read(file_path)).result
    hashie_name = file_path.gsub("#{settings_path}","")[0...-4]
    result[hashie_name.to_sym] = YAML.load(raw_config)[Rails.env]
    result.with_indifferent_access
  end

  puts "Settings for #{Rails.env} loaded"
end
