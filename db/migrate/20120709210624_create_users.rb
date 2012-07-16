class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :limit => 80
      t.string :password, :limit => 255

      t.timestamps
    end
  end
end
