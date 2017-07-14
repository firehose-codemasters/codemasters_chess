module GamesHelper
  def render_piece(x, y)
    piece_color = piece_at(x, y)&.color
    piece_type = piece_at(x, y)&.type

    case piece_type
    when 'Pawn'
      return image_tag('pieces/white_pawn.png') if piece_color == 'white'
      return image_tag('pieces/black_pawn.png') if piece_color == 'black'
    when 'Queen'
      return image_tag('pieces/white_queen.png') if piece_color == 'white'
      return image_tag('pieces/black_queen.png') if piece_color == 'black'
    when 'Rook'
      return image_tag('pieces/white_rook.png') if piece_color == 'white'
      return image_tag('pieces/black_rook.png') if piece_color == 'black'
    when 'Bishop'
      return image_tag('pieces/white_bishop.png') if piece_color == 'white'
      return image_tag('pieces/black_bishop.png') if piece_color == 'black'
    when 'King'
      return image_tag('pieces/white_king.png') if piece_color == 'white'
      return image_tag('pieces/black_king.png') if piece_color == 'black'
    when 'Knight'
      return image_tag('pieces/white_knight.png') if piece_color == 'white'
      return image_tag('pieces/black_knight.png') if piece_color == 'black'
    end
  end

  def piece_at(x, y)
    @game.pieces.find_by(x_position: x, y_position: y, active: true)
  end
end
