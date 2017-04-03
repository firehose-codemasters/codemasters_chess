require 'rails_helper'

RSpec.describe 'pieces/edit', type: :view do
  before do
    @piece = FactoryGirl.create(:piece)
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
