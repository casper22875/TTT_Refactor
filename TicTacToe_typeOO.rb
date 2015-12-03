class Board

attr_accessor :board

def initialize
	@board = board_grid
end

def board_grid
	["1", "2", "3", "4", "5", "6", "7", "8", "9"]
end
	
def grid_size
end
		
def update_board
end




	
end

class Player
	
attr_accessor :board,:player,:gametype,:marker

def initialize
	@player = ""
	@gametype = 1
	@marker = ""
end

def marker("")
	marker = "X" || "O"   
end

def player2(marker)
	 if marker == "X" 
	 player2_marker = "O"
	 else
	 player2_marker = "X"
	 end	 
end	
	
def determine_move()
	if 
	else 
	   
	end
end

	

end
	
	