class AddCampaignIdToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :campaign_id, :integer
  end
end
