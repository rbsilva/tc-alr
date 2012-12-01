class RenamePathToFileTagsToTemplateInRawFiles < ActiveRecord::Migration
  def up
    rename_column :raw_files, :path, :file
    rename_column :raw_files, :tags, :template
  end

  def down
    rename_column :raw_files, :file, :path
    rename_column :raw_files, :template, :tags 
  end
end
