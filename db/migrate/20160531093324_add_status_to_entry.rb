class AddStatusToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :sync_status, :string, default: 'pending'
    add_index :entries, [ :competition_id, :sync_status ]
  end
end
