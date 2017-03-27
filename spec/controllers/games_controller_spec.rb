require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  let(:valid_attributes) do
    {
      name: 'Chess',
      result: 'in_progress',
      white_player_id: user1.id,
      black_player_id: user2.id
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      result: '',
      white_player_id: nil,
      black_player_id: nil
    }
  end

  let(:new_attributes) do
    {
      name: 'New Chess',
      result: 'draw',
      white_player_id: user2.id,
      black_player_id: user1.id
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all games as @games' do
      get :index, params: {}, session: valid_session
      expect(assigns(:games)).to eq([game])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested game as @game' do
      get :show, params: { id: game.to_param }, session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe 'GET #new' do
    it 'assigns a new game as @game' do
      get :new, params: {}, session: valid_session
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested game as @game' do
      get :edit, params: { id: game.to_param }, session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Game' do
        expect do
          post :create, params: { game: valid_attributes }, session: valid_session
        end.to change(Game, :count).by(1)
      end

      it 'saves the new game to the database' do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(assigns(:game)).to be_persisted
      end

      it 'assigns a newly created game as @game' do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(assigns(:game)).to be_a(Game)
      end

      it 'redirects to the created game' do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved game as @game' do
        post :create, params: { game: invalid_attributes }, session: valid_session
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        post :create, params: { game: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested game' do
        put :update, params: { id: game.to_param, game: new_attributes }, session: valid_session
        game.reload
        expect(game.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested game as @game' do
        put :update, params: { id: game.to_param, game: valid_attributes }, session: valid_session
        expect(assigns(:game)).to eq(game)
      end

      it 'redirects to the game' do
        put :update, params: { id: game.to_param, game: valid_attributes }, session: valid_session
        expect(response).to redirect_to(game)
      end
    end

    context 'with invalid params' do
      it 'assigns the game as @game' do
        put :update, params: { id: game.to_param, game: invalid_attributes }, session: valid_session
        expect(assigns(:game)).to eq(game)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: game.to_param, game: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested game' do
      game = FactoryGirl.create(:game)
      expect do
        delete :destroy, params: { id: game.to_param }, session: valid_session
      end.to change(Game, :count).by(-1)
    end

    it 'redirects to the games list' do
      delete :destroy, params: { id: game.to_param }, session: valid_session
      expect(response).to redirect_to(games_url)
    end
  end
end
