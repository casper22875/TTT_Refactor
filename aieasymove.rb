class AIeasyMove
	def computer_random_move
		n = rand(0..8)
			if square_available?(n) == false
				computer_random_move()
			else
				return n
			end
	end
	
	