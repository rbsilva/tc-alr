class CreateAdminDataTables < ActiveRecord::Migration
  def change
    create_table :admin_data_tables do |t|
      t.string :name
      t.references :user
      t.boolean :fact

      t.timestamps
    end
    add_index :admin_data_tables, :user_id
  end
end
