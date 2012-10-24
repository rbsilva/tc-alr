class CreateTesteDimensions < ActiveRecord::Migration
  def change
    create_table :teste_dimensions do |t|
      t.text :teste

      t.timestamps
    end
  end
end
