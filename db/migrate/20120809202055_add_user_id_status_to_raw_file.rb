class AddUserIdStatusToRawFile < ActiveRecord::Migration
  def change
    change_table :raw_files do |t|
      t.references :user
      t.string :status
    end
    RawFile.update_all ["user_id = 1, status = 'SENT'"]
  end
end
