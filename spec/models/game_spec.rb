require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#initialize_board_white_pieces' do
    it 'will create a active white pawn at coordinates(1,2) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Pawn.where(x_position: 1, y_position: 2, color: 'white', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 8 white pawns' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Pawn.where(color: 'white', active: true).size).to eq(8)
    end
  end 
end
 