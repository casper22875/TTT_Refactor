class Human
	attr_accessor :name, :interface, :current_position, :marker
	
	def initialize
		@name = name
		@interface = interface
		@marker = marker
		@current_position = -1
	end
end
		
class PS_Human < Human
	def make_a_move(board)
		interface.get_move_human()
	end
end

class WebHuman < Human
	def make_a_move(board)
		@current_position
	end
end