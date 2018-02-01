class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :competition_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end

    add_index :entries, %i[competition_id email], unique: true
  end
end
