class Gameboard
	attr_accessor :grid, :winning_routes

	def initialize
		@grid = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
		@winning_routes = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
	end
	
	# def board_positions_array
	# ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	# end 
	
	def square_available?(current_position,xo_mark)
		@board[current_position] = xo_mark
	end
	
	def board_full?
		game_board = @board.join(",")
		if game_board =~ (/\d/) 
		false
		else
		true
		end
	end
	
	def winner?(marker)
		result = false
		winning_routes.each do |group|
			if board[group[0]] == player && board[group[1]] == player && board[group[2]] == player
				result = true
			end
		end
		result
	end
	
	def end_game?
		marker = previous_marker()
		winner?(marker) || tie?()
	end
	
	def previous_marker()
		(@board.length - @board.count(" "))%2 == 0 ? "O" : "X"
	end
	
	def next_marker()
		previous_marker() == "O" ? "X" : "O"
	end
	
	def valid_marker?(marker)
	marker == "X" || marker=="O"
	end
	
	def tie?()
		@board.count("1..9") == 0
	end
end