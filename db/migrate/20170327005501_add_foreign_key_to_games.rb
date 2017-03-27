class AddForeignKeyToGames < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :games, :users, column: :white_player_id
    add_foreign_key :games, :users, column: :black_player_id
  end
end
