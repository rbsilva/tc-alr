class CreateTetDimensions < ActiveRecord::Migration
  def change
    create_table :tet_dimensions do |t|
      t.binary :teste

      t.timestamps
    end
  end
end
