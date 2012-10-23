class CreateDataTables < ActiveRecord::Migration
  def change
    create_table :data_tables do |t|
      t.string :name
      t.references :user
      t.boolean :fact

      t.timestamps
    end
    add_index :data_tables, :user_id
  end
end
