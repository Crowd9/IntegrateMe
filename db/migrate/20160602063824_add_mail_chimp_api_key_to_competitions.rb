class AddMailChimpApiKeyToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :mail_chimp_api_key, :string
  end
end
