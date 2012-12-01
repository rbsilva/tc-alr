class CreateRawFiles < ActiveRecord::Migration
  def change
    create_table :raw_files do |t|
      t.string :path
      t.string :tags

      t.timestamps
    end
  end
end
