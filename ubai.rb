class UBAI
	def negamax(board, mark, depth)
		mark == "X" ? opponent = "O" : opponent = "X"
		if winner?(mark) || board_full?()
			return game_result(mark, opponent)
		else 
			max = -1.0/0
			available_moves.each do |space|
				board[space] = mark
				score = -negamax(board, opponent, depth + 1)
				board[space] = "#{space + 1}"
				if score > max
					max = score
					if depth == 1
					@best_move = space
					end
				end
			end
			return max
		end
	end
	
	def available_moves()
		board.each_index.select { |s| board[s] != "X" && board[s] != "O"}
	end
	
	def game_result(mark, opponent)
		if winner?(mark)
			return 1
		elsif winner?(opponent)
			return -1
		else 
			return 0
		end
	end
	
	def computer_winning_move
		player_marker = current_player()
		move = false
		winning_routes.each do |group|
		count = 0
			group.each do |value|
				count += 1 if board[value] == player_marker
			end
			
			if count == 2
				group.each do |value|
					if board[value] != "X" && board[value] != "O"
						# board[value] = player_marker
						@medium_move = value
						move = true
					end
				end
			end
		break if move == true
		end
		move
	end
	
	def computer_blocking_move
		player_marker = current_player()
		opponent = opposite_player()
		move = false
		winning_routes.each do |group|
		count = 0
			group.each do |value|
				count += 1 if board[value] == opponent
			end
			
			if count == 2
				group.each do |value|
					if board[value] != "X" && board[value] != "O"
						# board[value] = player_marker
						@medium_move = value
						move = true
					end
				end
			end
		break if move == true
		end
		move
	end
	
	def computer_fork_move
		player_marker = current_player()
		move = false
		fork_routes.each do |group|
		count = 0
			group.each do |value|
				count += 1 if board[value] == player_marker
			end
			
			if count == 2
				group.each do |value|
					if board[value] != "X" && board[value] != "O"
						# board[value] = player_marker
						@medium_move = value
						move = true
					end
				end
			end
		break if move == true
		end
		move
	end
	
	def computer_fork_block
		player_marker = current_player()
		opponent = opposite_player()
		move = false
		fork_routes.each do |group|
		count = 0
			group.each do |value|
				count += 1 if board[value] == opponent
			end
			
			if count == 2
				group.each do |value|
					if board[value] != "X" && board[value] != "O"
						# board[value] = player_marker
						@medium_move = value
						move = true
					end
				end
			end
		break if move == true
		end
		move
	end
	
	def computer_random_move
		n = rand(0..8)
			if square_available?(n) == false
				computer_random_move()
			else
				return n
			end
	end