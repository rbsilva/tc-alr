class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :type
      t.string :description
      t.boolean :is_null
      t.references :table

      t.timestamps
    end
    add_index :fields, :table_id
  end
end
