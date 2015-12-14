require 'sinatra'

require_relative "TicTacToe_typeOO.rb"


ai = AI.new()

get '/tictactoe' do
	ai = AI.new()
	erb :gametype, :locals => {:error => "", :board => ai.game_board.board}
end

post '/tictactoe' do
	ai.players.type = params[:GameType]
	if ai.players.type == "1"
		erb :level, :locals => {:error => "", 
								:board => ai.game_board.board}
	else
		erb :marker, :locals => {:error => "", 
								 :board => ai.game_board.board}
	end
end

post '/marker' do
		ai.difficulty = params[:difficulty] if ai.players.type == "1" 
		puts "ai initialization"
	erb :marker, :locals => {:error => "", 
							 :board => ai.game_board.board}
end

post '/squares' do
	ai.players.player1 = params[:XorO]
	ai.players.player2 = ai.players.p2marker()
	erb :squares, :locals => {:p1 => ai.players.player1, 
							  :p2 => ai.players.player2, 
							  :error => "", 
							  :error2 => "", 
							  :current => ai.players.current, 
							  :board => ai.game_board.board, 
							  :type => ai.players.type}
end

post '/game' do
	choice = params[:square].to_i
	player_marker = ai.players.current_player()
	
	if ai.game_board.square_available?(choice - 1) == true
		ai.game_board.board[choice - 1] = player_marker
		redirect to('/status')
	else
		erb :squares, :locals => {:p1 => ai.players.player1, 
								  :p2 => ai.players.player2, 
								  :error => "#{choice} is already taken", 
								  :error2 => "Please choose again.", 
								  :current => ai.players.current, 
								  :board => ai.game_board.board, 
								  :type => ai.players.type}
	end	
end

get '/cpu' do
	sleep 1
	player_marker = ai.players.current_player()
	move = ai.computer_move(ai.difficulty)
	ai.game_board.board[move] = player_marker
	redirect to('/status')
end

get '/status' do
	if ai.game_board.winner?(ai.players.current_player) == true
		redirect to('/win')
	elsif ai.game_board.board_full?() == true
		redirect to('/tie')
	end
	
	ai.players.current = ai.players.change()
	redirect to('/cpu') if ai.players.type == "1" && ai.players.current == 2
	erb :squares, :locals => {:p1 => ai.players.player1, 
							  :p2 => ai.players.player2, 
							  :error => "", 
							  :error2 => "", 
							  :current => ai.players.current, 
							  :board => ai.game_board.board, 
							  :type => ai.players.type}	
end

get '/win' do
	erb :gameover, :locals => {:p1 => "Player #{ai.players.current} wins!!!", 
							   :board => ai.game_board.board}
end

get '/tie' do
	erb :gameover, :locals => {:p1 => "It's a tie.", 
							   :board => ai.game_board.board}
end

post '/new' do
	ai = AI.new()
	# game_board = Board.new()
	# players = Players.new()
	redirect to('/tictactoe')
end