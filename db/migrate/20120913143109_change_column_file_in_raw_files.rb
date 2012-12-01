class ChangeColumnFileInRawFiles < ActiveRecord::Migration
  def change
    remove_column :raw_files, :file
    add_column :raw_files, :file, :binary
  end
end
