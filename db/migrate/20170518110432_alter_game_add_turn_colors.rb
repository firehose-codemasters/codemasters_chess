class AlterGameAddTurnColors < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :current_color, :string, default: 'white'
    add_column :games, :resting_color, :string, default: 'black'
  end
end
