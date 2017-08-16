class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :competition_id, index: true
      t.string :name
      t.string :email

      t.timestamps null: false
    end

    add_index :entries, [:competition_id, :email], unique: true
  end
end
