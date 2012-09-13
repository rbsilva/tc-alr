class ChangeColumnFileInRawFiles < ActiveRecord::Migration
  def change
    change_column :raw_files, :file, :binary
  end
end
