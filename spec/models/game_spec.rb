require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'initialize_board_white_pieces' do
    it 'will create 16 pieces in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      binding.pry
      expect(game.pieces.count).to eq(16)
    end
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
    it 'will create a active white rook at coordinates(1,1) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Rook.where(x_position: 1, y_position: 1, color: 'white', active: true).exists?).to eq(true)
    end
    it 'will create 2 white rooks' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Rook.where(color: 'white', active: true).size).to eq(2)
    end
    it 'will create a active white knight at coordinates(2,1) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Knight.where(x_position: 2, y_position: 1, color: 'white', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 2 white knights' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Knight.where(color: 'white', active: true).size).to eq(2)
    end
    it 'will create a active white bishop at coordinates(3,1) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Bishop.where(x_position: 3, y_position: 1, color: 'white', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 2 white bishops' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Bishop.where(color: 'white', active: true).size).to eq(2)
    end
    it 'will create a active white queen at coordinates(4,1) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Queen.where(x_position: 4, y_position: 1, color: 'white', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 1 white queen' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(Queen.where(color: 'white', active: true).size).to eq(1)
    end
    it 'will create a active white king at coordinates(5,1) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(King.where(x_position: 5, y_position: 1, color: 'white', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 1 white king' do
      game = FactoryGirl.create(:game)
      game.initialize_board_white_pieces
      expect(King.where(color: 'white', active: true).size).to eq(1)
    end
  end
end
RSpec.describe Game, type: :model do
  describe 'initialize_board_black_pieces' do
    it 'will create 16 pieces in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Piece.where(game_id: game.id).length).to eq(16)
    end
    it 'will create a active back pawn at coordinates(1,7) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Pawn.where(x_position: 1, y_position: 7, color: 'black', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 8 black pawns' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Pawn.where(color: 'black', active: true).size).to eq(8)
    end
    it 'will create a active black rook at coordinates(1,8) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Rook.where(x_position: 1, y_position: 8, color: 'black', active: true).exists?).to eq(true)
    end
    it 'will create 2 black rooks' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Rook.where(color: 'black', active: true).size).to eq(2)
    end
    it 'will create a active black knight at coordinates(2,8) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Knight.where(x_position: 2, y_position: 8, color: 'black', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 2 black knights' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Knight.where(color: 'black', active: true).size).to eq(2)
    end
    it 'will create a active black bishop at coordinates(3,8) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Bishop.where(x_position: 3, y_position: 8, color: 'black', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 2 black bishops' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Bishop.where(color: 'black', active: true).size).to eq(2)
    end
    it 'will create a active black queen at coordinates(4,8) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Queen.where(x_position: 4, y_position: 8, color: 'black', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 1 black queen' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(Queen.where(color: 'black', active: true).size).to eq(1)
    end
    it 'will create a active black king at coordinates(5,8) in the database' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(King.where(x_position: 5, y_position: 8, color: 'black', active: true).exists?).to eq(true)
      # Game.pieces into line 8?
    end
    it 'will create 1 black king' do
      game = FactoryGirl.create(:game)
      game.initialize_board_black_pieces
      expect(King.where(color: 'black', active: true).size).to eq(1)
    end
  end
end

RSpec.describe Game, type: :model do
  describe 'next_turn' do
    it 'will switch current_color from white to black' do
      game = FactoryGirl.create(:game)
      game.next_turn
      expect(game.current_color).to eq('black')
    end
    it 'will switch resting_color from black to white' do
      game = FactoryGirl.create(:game)
      game.next_turn
      expect(game.resting_color).to eq('white')
    end
  end
end
