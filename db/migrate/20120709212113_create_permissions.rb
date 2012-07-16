class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :description, :limit => 80
      t.string :path, :limit => 255

      t.timestamps
    end
  end
end
