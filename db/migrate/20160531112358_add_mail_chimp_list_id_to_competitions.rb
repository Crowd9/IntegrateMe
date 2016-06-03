class AddMailChimpListIdToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :mail_chimp_list_id, :string
  end
end
