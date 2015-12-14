class AI
	include Board
	include Players
	attr_accessor :difficulty, :fork_routes, :game_board, :players
	
	def initialize
		@game_board = Gameboard.new
		@players = Gameplayers.new
		@difficulty = ""
		@fork_routes = [[0,2,6],[0,2,8],[0,6,8],[2,6,8],[0,2,5],[0,2,3],[5,6,8],[3,6,8],[0,2,4],[2,4,8],[0,4,6],[6,4,8]]
	end
	
	def computer_move(difficulty)
		case difficulty