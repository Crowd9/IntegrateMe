class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :code
      t.text :raw

      t.timestamps :null => false
    end
  end
end
