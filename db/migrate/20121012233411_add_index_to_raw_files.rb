class AddIndexToRawFiles < ActiveRecord::Migration
  def change
    add_index :raw_files, :user_id
  end
end
