require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create :game }

  describe '#set_pieces' do
    before { game.set_pieces }

    it 'puts 32 pieces on the board' do
      expect(game.pieces.count).to eq 32
    end

    it 'puts the right number of pieces on the board by type' do
      expect(Bishop.active.black.size).to eq 2
      expect(Bishop.active.white.size).to eq 2
      expect(King.active.black.size).to eq 1
      expect(King.active.white.size).to eq 1
      expect(Knight.active.black.size).to eq 2
      expect(Knight.active.white.size).to eq 2
      expect(Pawn.active.black.size).to eq 8
      expect(Pawn.active.white.size).to eq 8
      expect(Queen.active.black.size).to eq 1
      expect(Queen.active.white.size).to eq 1
      expect(Rook.active.black.size).to eq 2
      expect(Rook.active.white.size).to eq 2
    end

    it 'puts pieces in the right location' do
      expect(Bishop.active.white.at(3, 1)).to exist
      expect(Bishop.active.black.at(3, 8)).to exist
      expect(King.active.white.at(5, 1)).to exist
      expect(King.active.black.at(5, 8)).to exist
      expect(Knight.active.white.at(2, 1)).to exist
      expect(Knight.active.black.at(2, 8)).to exist
      expect(Pawn.active.white.at(1, 2)).to exist
      expect(Pawn.active.black.at(1, 7)).to exist
      expect(Queen.active.white.at(4, 1)).to exist
      expect(Queen.active.black.at(4, 8)).to exist
      expect(Rook.active.white.at(1, 1)).to exist
      expect(Rook.active.black.at(1, 8)).to exist
    end
  end

  describe '#next_turn' do
    before { game.next_turn }

    it 'will switch current_color from white to black' do
      expect(game.current_color).to eq('black')
    end

    it 'will switch resting_color from black to white' do
      expect(game.resting_color).to eq('white')
    end
  end
end
