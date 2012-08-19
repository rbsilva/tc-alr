class InitialChargeRoles < ActiveRecord::Migration
  def up
    add_index :roles, :name, :unique => true
    Role.new(:name => 'admin', :models => ['all']).save()
  end

  def down
    remove_index :roles, :name
    Role.find_by_name('admin').destroy
  end
end
