class CreateAdminReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :description
      t.text :fields
      t.references :user

      t.timestamps
    end
    add_index :reports, :user_id
  end
end
