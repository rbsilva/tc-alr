class AddIndexToInbounds < ActiveRecord::Migration
  def change
    add_index :inbounds, :raw_file_id
  end
end
