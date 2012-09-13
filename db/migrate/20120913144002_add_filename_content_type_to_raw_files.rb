class AddFilenameContentTypeToRawFiles < ActiveRecord::Migration
  def change
    change_table :raw_files do |t|
      t.string   "filename",        :default => "", :null => false
      t.string   "content_type",    :default => "", :null => false
    end
  end
end
