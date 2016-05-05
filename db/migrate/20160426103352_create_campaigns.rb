class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :list_id
      t.string :subject_line
      t.string :title
      t.string :from_name
      t.string :reply_to
      t.string :type
      t.string :api_key
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
