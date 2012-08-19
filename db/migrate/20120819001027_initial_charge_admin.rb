class InitialChargeAdmin < ActiveRecord::Migration
  def up
    User.new(:full_name => 'admin', :email => 'admin@admin.com', :password => 'adminpass', :password_confirmation => 'adminpass', :role_ids => [1], :user => 'admin', :delete_flag => 0, :active_flag => 1).save()
  end

  def down
    User.find_by_user('admin').destroy
  end
end
