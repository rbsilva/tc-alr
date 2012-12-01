class CreateInbounds < ActiveRecord::Migration
  def change
    create_table :inbounds do |t|
      t.binary :file
      t.references :raw_file

      t.timestamps
    end
  end
end
