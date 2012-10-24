class CreateTeste2Dimensions < ActiveRecord::Migration
  def change
    create_table :teste2_dimensions do |t|
      t.binary :teste

      t.timestamps
    end
  end
end
