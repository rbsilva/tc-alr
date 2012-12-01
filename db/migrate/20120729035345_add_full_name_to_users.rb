class AddFullNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :full_name
    end
    User.update_all ["full_name = ?", "Fulano da Silva Beltrano"]
  end
end
