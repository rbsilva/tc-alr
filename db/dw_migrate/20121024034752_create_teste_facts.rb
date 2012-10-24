class CreateTesteFacts < ActiveRecord::Migration
  def change
    create_table :teste_facts do |t|
      t.references :teste_dimension

      t.timestamps
    end
    add_index :teste_facts, :teste_dimension_id
  end
end
