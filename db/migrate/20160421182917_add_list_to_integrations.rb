class AddListToIntegrations < ActiveRecord::Migration
  def change
    add_column :integrations, :list, :string
  end
end
