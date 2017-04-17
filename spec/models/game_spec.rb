require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#initialize_board_white_pieces' do
  	it 'should create a active white pawn at coordinates(1,2) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Piece.where(x_position: 1, y_position: 2, color: 'white', active: true, type: 'pawn').exists?).to eq(true)
   end
  end 
end




  describe '#obstructed_diagonally?' do
    it 'returns true if the move is obstructed in the up-right direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 8, to_y: 8)).to eq(true)
    end