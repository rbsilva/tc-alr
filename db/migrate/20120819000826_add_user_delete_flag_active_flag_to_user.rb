class AddUserDeleteFlagActiveFlagToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :user
      t.integer :delete_flag
      t.integer :active_flag
    end
    add_index :users, :user, :unique => true
    User.update_all ["delete_flag = 0, active_flag = 1"]
  end
end
