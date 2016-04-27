class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.string :api_key
      t.string :api_token
      t.string :name
      t.string :type

      t.timestamps null: false
    end
  end
end
