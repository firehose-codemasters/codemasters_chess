class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :result
      t.references :white_player
      t.references :black_player

      t.timestamps
    end
  end
end
