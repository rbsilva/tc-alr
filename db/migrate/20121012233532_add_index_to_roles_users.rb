class AddIndexToRolesUsers < ActiveRecord::Migration
  def change
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
  end
end
