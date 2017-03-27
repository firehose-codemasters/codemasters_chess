require 'rails_helper'

RSpec.describe 'games/new', type: :view do
  before do
    assign(:game, Game.new)
  end

  it 'renders new game form' do
    render

    assert_select 'form[action=?][method=?]', games_path, 'post' do
      assert_select 'input#game_name[name=?]', 'game[name]'
      assert_select 'input#game_result[name=?]', 'game[result]'
      assert_select 'input#game_white_player_id[name=?]', 'game[white_player_id]'
      assert_select 'input#game_black_player_id[name=?]', 'game[black_player_id]'
    end
  end
end
