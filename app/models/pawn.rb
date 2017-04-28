class Pawn < Piece
	
def valid_move?
	return true if normal_move?(to_x, to_y)
	return false if backwards_move(to_x, to_y)
	return true if first_move?(first_move, to_y) #how do we keep track of first move
	return true if pawn_diagonal?(to_x, to_y)
	return true if capture_piece?(to_x, to_y)
	return true if en_passant?(to_x, to_y)
	false
end



#how are we defining the good guys vs. the bad guys? by color

#need to have something that addresses the white moving one way and the black moving the other

private

def normal_move?(to_x, to_y)
	return (to_x - x_position).abs == 0 && (to_y - y_position).abs == 1
end

def backwards_move?(to_x, to_y)
	#color ? to_y > y_position || y_position > to_x
end 


def pawn_diagonal?(to_x, to_y)
 	return (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
end


def first_move?(first_move, to_y)
 first_move = (to_y - y_position).abs == 1 || (to_y - y_position).abs == 2
end

# Capture logic here


def capture_piece(to_x, to_y)	
	to_x == (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1 && #enemy_at(to_x, to_y)
end

def enpassant
	

end



#need many methods for capture
	#need to know there is an enemy piece/opposite color piece present piece.where
	#need to make sure it does not invoke the obstruction logic? 
	#need to establish the move logic
#










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
