

class Gameboard
	attr_accessor :board, :winning_routes

	def initialize
		@board = board_positions_array
		@winning_routes = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
	end
	
	def board_positions_array
	["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	end 
	
	def square_available?(choice)
		@board[choice] != "X" && @board[choice] != "O"
	end
	
	def board_full?
		game_board = @board.join(",")
		if game_board =~ (/\d/) 
		false
		else
		true
		end
	end
	
	def winner?(player)
		result = false
		winning_routes.each do |group|
			if board[group[0]] == player && board[group[1]] == player && board[group[2]] == player
				result = true
			end
		end
		result
	end
end