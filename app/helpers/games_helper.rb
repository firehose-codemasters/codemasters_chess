module GamesHelper
  def render_piece(game_id, x, y)
    return "game_id: #{game_id}, x: #{x}, y: #{y}"
    # return 'piece!' if Piece.find(game_id: game_id, x_position: x, y_position: y, active: true)
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
