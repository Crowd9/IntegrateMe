class AddEntryMailChimpSubscribed < ActiveRecord::Migration
  def change
    add_column :entries, :mail_chimp_subscribed, :boolean, :default => nil
  end
end
