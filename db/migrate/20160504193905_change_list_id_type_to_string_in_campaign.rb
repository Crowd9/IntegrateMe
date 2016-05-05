class ChangeListIdTypeToStringInCampaign < ActiveRecord::Migration
  def change
    change_column :campaigns, :list_id, :string
  end
end
