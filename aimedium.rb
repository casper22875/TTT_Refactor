class AImediumMove
	def medium_ai
		if computer_winning_move()
		elsif computer_blocking_move()
		elsif computer_fork_move()
		elsif computer_fork_block()			
		elsif @medium_move = computer_random_move()
		end
		return @medium_move
	end
end