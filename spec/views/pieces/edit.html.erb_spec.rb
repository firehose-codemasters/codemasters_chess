require 'rails_helper'

RSpec.describe 'pieces/edit', type: :view do
  before do
    @game = assign(:game, FactoryGirl.create(:game))

    # @piece = assign(:piece, Piece.create!(
    @piece = assign(:piece, FactoryGirl.create!(
      color: 'MyString',
      active: false,
      x_position: 1,
      y_position: 1,
      type: '',
      game: game.id
    ))
  end

  it 'renders the edit piece form' do
    render

    assert_select 'form[action=?][method=?]', piece_path(@piece), 'post' do
      assert_select 'input#piece_color[name=?]', 'piece[color]'

      assert_select 'input#piece_active[name=?]', 'piece[active]'

      assert_select 'input#piece_x_position[name=?]', 'piece[x_position]'

      assert_select 'input#piece_y_position[name=?]', 'piece[y_position]'

      assert_select 'input#piece_type[name=?]', 'piece[type]'

      assert_select 'input#piece_game_id[name=?]', 'piece[game_id]'
    end
  end
end
