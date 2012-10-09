class AddHeaderToRawFile < ActiveRecord::Migration
  def change
    change_table :raw_files do |t|
      t.string :header
    end
  end
end
