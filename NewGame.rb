class Game	

	attr_accessor :board, :player1, :player2, :current_player
	
	def initialize(player1_details,player2_details)
		
		
		@player1 = player_set(player1_details, "X")
		@player2 = player_set(player2_details, "O")
	end


	def make_current_player
		if	board.next_marker == "X"
			return player1 
		else
			return player2
		end
	end
	
	def make_your_move(current_player)
		current_player.make_the_move(board)
	end
	
	def make_a_move(position)
		board.update_board(position,board.next_marker)
	end
	
	def win_game?
		board.game_won?
	end
	
	def valid_square?(position)
		board.valid_square?(position)	 
	end
	
	def player_set(players_details,marker)
	type = players_details[0]
	name = players_details[1]
	level = players_details[2]
		if level == "Easy"
			AIeasyMove.new("AI (difficulty #{difficulty})", marker)
		elsif level == "Medium"
			AImediumMove.new("AI (difficulty #{difficulty})", marker)
		elsif level == "Hard"
			UBAI.new("AI (difficulty #{difficulty})", marker)
		end
	end
end

			
			
			
			
			