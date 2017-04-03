class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :color
      t.boolean :active
      t.integer :x_position
      t.integer :y_position
      t.string :type
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
