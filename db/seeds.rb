# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(:name => 'admin', :models => ['all'])
role = Role.find_by_name 'admin'
User.create(:full_name => 'admin', :email => 'admin@admin.com', :password => 'adminpass', :password_confirmation => 'adminpass', :role_ids => [role.id],:user => 'admin', :delete_flag => 0, :active_flag => 1)