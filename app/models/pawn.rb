class Pawn < Piece
	
def valid_move_and_no_way_jose_move?
	straight_ahead = (to_y - y_position).abs 
	return true if straight_ahead != 0 && (to_y - y_position).abs == 1
end

def first_move
 first_move = (to_y - y_position).abs == 1 || (to_y - y_position).abs == 2
end

def enpassant
end


#possible moves
	#to_y + 2
	#to_y + 1
	#to_y + 1 && to_x + 1










#define what you can do


	#first_move = y_position + 2 || y_position + 1
	# else y_position = y_position + 1
	#first move: move one space or two spaces
	#after first move: can only move one space
	#taking a piece only happens from the side
	##should move up to two pieces on first move and one piece only after that.
	#should also be able to move diagonally when there is a piece present



	#how to leverage piece logic? 




end
