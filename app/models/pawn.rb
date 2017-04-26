class Pawn < Piece
	attr_accessor :to_x, :to_y

def starting_point_and_move_directions
	{ white: 2, black: 7}
	{ white: 1, black: -1 }
end

def valid_move_and_no_way_jose_move?
	if color == "white" to_y < y_position && to_y > y_position return false#checking for obstructions
	if color == "white" && to_y > y_position return true	
end

def board_space_occupied?(x,y)
	unless game.piece_at(x,y)
		return true
end

def first_move
 self.first_move to_y > y_position + 1 || self.first_move to_y > y_position + 2 
end


return false if obstructed_vertically(to_x, to_y)

	#should be checking for obstructions also


end

def first_move #will not have an obstruction

end

#possible moves
	#to_y + 2
	#to_y + 1
	#to_y + 1 && to_x + 1







#define what you can't do
	#forwards? backwards? sideways? diagonally?


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
