class Game

	attr_accessor :interface, :board, player1, :player2, :current_player
	
	def initialize(board,player1type,player2type)
		@interface = interface
		@board = Gameboard.new
		@player1type = player_set(player1_details, "X")
		@player2type = player_set(player2_details, "O")
	end
	
	def make_current_player
		if	Gameboard.next_marker == "X"
			return player1 
		else
			return player2
		end
	end
	
	def make_your_move(current_player)
		current_player.make_the_move(board)
	end
	
	def make_a_move(position)
		Gameboard.update_board(current_position,board.next_marker)
	end
	
	def win_game?
		Gameboard.winner?
	end
	
	def valid_square?(current_position)
		Gameboard.valid_square?(current_position)	 
	end
	
	def player_set(players_details,marker)
	type = players_details[0]
	name = players_details[1]
	level = players_details[2]
		if type == "Console"
			PS_Human.new(interface,name,marker)
		elsif type == "Human"
			WebHuman.new(interface, name, marker)
		else
			if difficulty == "Easy"
				AIeasyMove.new("AI (difficulty #{difficulty})", marker)
			elsif difficulty == "Medium"
				AImediumMove.new("AI (difficulty #{difficulty})", marker)
			elsif difficulty == "Hard"
				UBAI.new("AI (difficulty #{difficulty})", marker)
			end
		end
	end
end

			
			
			
			
			