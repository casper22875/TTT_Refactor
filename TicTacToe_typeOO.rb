class TicTacToe
	
	attr_accessor :player1,:player2,:playerAI,:gametype

def initialize(player1,player2)
	@player1 = player
	@player2 = player
	@playerAI = playerAI
	@gametype = gametype
def gametype
end



	
end	
	







class Board

attr_accessor :board

def initialize(board)
	@board = board_grid
	@grid_console = grid_console
end

def board_grid
	["1", "2", "3", "4", "5", "6", "7", "8", "9"]
end
	
def grid_console
	
	puts """
	  |  |
	#{@board[0]} | #{@board[1]}| #{@board[2]}
	__|__|__   
	  |  |  
	#{@board[3]} | #{@board[4]}| #{@board[5]}
	__|__|__
	#{@board[6]} | #{@board[7]}| #{@board[8]}
	  |  |"""
end
		
def update_board
	

end




	
end

class Player
	
attr_accessor :player1,:player2,:markers

def initialize(player1,player2,markers)
	@player1 = ""
	@player2 = ""
	@markers = ""
end

def markers
	
end


	

def players(markers)
	 if 
	 else
	 
	 end	 
end	
	
# def determine_move()
	# if 
# end

end
	
class ConsoleHuman :: Player
	
	attr_accessor :determine_move
	
end

class WebHuman :: Player

	attr_accessor :determine_move

end

class AI :: Player

	attr_accessor :determine_move,:easyAI
	
def initialize(easyAI,determine_move)
	@easyAI = easyAI
	@determine_move
	
def easyAI(board)
	array = rand(1..9)
	if @valid_square?(array,board) == false
	   easyAI(board)
	else
	   @player_marker = change_player()
	   board[array - 1] = @player_marker
    end
end		
end


