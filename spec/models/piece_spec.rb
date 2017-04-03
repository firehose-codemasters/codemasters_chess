require 'rails_helper'

describe Piece, type: :model do
  describe '.new' do
    it 'allows me to make a new Piece' do
      expect(Piece.new).to be_a(Piece)
    end
  end

  describe '#valid_move?' do
    let(:piece) { create :piece }

    context 'when I try to move a piece off the board' do
      it 'has a negative x coordinate' do
        expect(piece.valid_move?(to_x: -1, to_y: 1)).to eq false
      end

      it 'has a negative y coordinate' do
        expect(piece.valid_move?(to_x: 1, to_y: -1)).to eq false
      end
    end
  end
end
