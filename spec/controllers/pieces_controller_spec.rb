require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  let(:game1) { FactoryGirl.create(:game) }
  let(:game2) { FactoryGirl.create(:game) }

  let(:valid_attributes) do
    {
      color: 'white',
      active: true,
      x_position: 1,
      y_position: 1,
      # Type needs to be implemented when first piece is created:
      # type: 'rook',
      game_id: game1.id
    }
  end

  let(:invalid_attributes) do
    {
      color: '',
      active: nil,
      x_position: nil,
      y_position: nil,
      # Type needs to be implemented when first piece is created:
      # type: '',
      game_id: nil
    }
  end

  let(:new_attributes) do
    {
      color: 'black',
      active: false,
      x_position: 2,
      y_position: 2,
      # # Type needs to be implemented when first piece is created:
      # type: 'rook',
      game_id: game2.id
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all pieces as @pieces' do
      piece = Piece.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:pieces)).to eq([piece])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested piece as @piece' do
      piece = Piece.create! valid_attributes
      get :show, params: { id: piece.to_param }, session: valid_session
      expect(assigns(:piece)).to eq(piece)
    end
  end

  describe 'GET #new' do
    it 'assigns a new piece as @piece' do
      get :new, params: {}, session: valid_session
      expect(assigns(:piece)).to be_a_new(Piece)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested piece as @piece' do
      piece = Piece.create! valid_attributes
      get :edit, params: { id: piece.to_param }, session: valid_session
      expect(assigns(:piece)).to eq(piece)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Piece' do
        expect do
          post :create, params: { piece: valid_attributes }, session: valid_session
        end.to change(Piece, :count).by(1)
      end

      it 'assigns a newly created piece as @piece' do
        post :create, params: { piece: valid_attributes }, session: valid_session
        expect(assigns(:piece)).to be_a(Piece)
        expect(assigns(:piece)).to be_persisted
      end

      it 'redirects to the created piece' do
        post :create, params: { piece: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Piece.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved piece as @piece' do
        post :create, params: { piece: invalid_attributes }, session: valid_session
        expect(assigns(:piece)).to be_a_new(Piece)
      end

      it "re-renders the 'new' template" do
        post :create, params: { piece: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested piece' do
        piece = FactoryGirl.create(:queen, x_position: 2, y_position: 2)
        put :update, params:
            {
              id: piece.to_param, piece:
                {
                  color: 'white',
                  active: true,
                  x_position: 4,
                  y_position: 4,
                  # # Type needs to be implemented when first piece is created:
                  # type: 'rook',
                  game_id: game2.id
                }
            }, session: valid_session
        piece.reload
        expect(piece.x_position).to eq(4)
      end

      it 'advances the game to the next turn' do
        piece = FactoryGirl.create(:queen, x_position: 2, y_position: 2, game_id: game2.id)
          put :update, params:
            {
              id: piece.to_param, piece:
                {
                  color: 'white',
                  active: true,
                  x_position: 4,
                  y_position: 4,
                  # # Type needs to be implemented when first piece is created:
                  # type: 'rook',
                  game_id: game2.id
                }
            }, session: valid_session
        game2.reload
        expect(game2.current_color).to eq('black')
      end
    end

    context 'with invalid params' do
      it 'does not update the requested piece' do
        piece = FactoryGirl.create(:queen, x_position: 2, y_position: 2)
        put :update, params:
            {
              id: piece.to_param, piece:
                {
                  color: 'white',
                  active: true,
                  x_position: 9,
                  y_position: 4,
                  # # Type needs to be implemented when first piece is created:
                  # type: 'rook',
                  game_id: game2.id
                }
            }, session: valid_session
        piece.reload
        expect(piece.x_position).to eq(2)
      end

      it 'does not advance the game to the next turn' do
        piece = FactoryGirl.create(:queen, x_position: 2, y_position: 2, game_id: game2.id)
          put :update, params:
            {
              id: piece.to_param, piece:
                {
                  color: 'white',
                  active: true,
                  x_position: 9,
                  y_position: 13,
                  # # Type needs to be implemented when first piece is created:
                  # type: 'rook',
                  game_id: game2.id
                }
            }, session: valid_session
        game2.reload
        expect(game2.current_color).to eq('white')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested piece' do
      piece = Piece.create! valid_attributes
      expect do
        delete :destroy, params: { id: piece.to_param }, session: valid_session
      end.to change(Piece, :count).by(-1)
    end

    it 'redirects to the pieces list' do
      piece = Piece.create! valid_attributes
      delete :destroy, params: { id: piece.to_param }, session: valid_session
      expect(response).to redirect_to(pieces_url)
    end
  end
end
