class AddModelsToRole < ActiveRecord::Migration
  def change
    change_table :roles do |t|
      t.string :models
    end
  end
end
