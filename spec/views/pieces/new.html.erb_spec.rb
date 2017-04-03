require 'rails_helper'

RSpec.describe 'pieces/new', type: :view do
  before do
    assign(:piece, Piece.new(
      color: 'MyString',
      active: false,
      x_position: 1,
      y_position: 1,
      type: '',
      game: nil
    ))
  end

  it 'renders new piece form' do
    render

    assert_select 'form[action=?][method=?]', pieces_path, 'post' do
      assert_select 'input#piece_color[name=?]', 'piece[color]'

      assert_select 'input#piece_active[name=?]', 'piece[active]'

      assert_select 'input#piece_x_position[name=?]', 'piece[x_position]'

      assert_select 'input#piece_y_position[name=?]', 'piece[y_position]'

      assert_select 'input#piece_type[name=?]', 'piece[type]'

      assert_select 'input#piece_game_id[name=?]', 'piece[game_id]'
    end
  end
end
