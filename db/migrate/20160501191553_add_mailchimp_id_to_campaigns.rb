class AddMailchimpIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :mailchimp_id, :string
  end
end
