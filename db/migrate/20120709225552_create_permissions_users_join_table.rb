class CreatePermissionsUsersJoinTable < ActiveRecord::Migration
  def up
    create_table :permissions_users, :id => false do |t|
      t.integer :permission_id
      t.integer :user_id
    end
  end

  def down
    drop_table :permissions_users
  end
end
