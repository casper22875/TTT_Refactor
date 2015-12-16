require 'sinatra'
require_relative "NewGame.rb"
require_relative "ai.rb"
require_relative"gameplayers.rb"
require_relative"gameboard.rb"




get '/tictactoe' do
	type= params[:typeofgame]
	erb :OneplayerorTwoplayer, :locals => {:message => "", :board => ai.play_board.board}
end

post '/tictactoe' do
	player1_details = [params[:player1], params[player1_name], [params[player1_difficulty]]
	player2_details = [params[:player2], params[player2_name], [params[player2_difficulty]]
	players_details = [player1_details, player2_details]
	game = Game.new(board.new, player1_details, player2_details)
	erb :howhard, :locals => {:message => "You Chose to play a 1 player game", :board => game.board}
	else
		erb :marker, :locals => {:message => "You Chose to play a 2 player game", :board => game.board}
	end
end

post '/marker' do
		game.difficulty = params[:difficulty] if game.players.type == "1"
	
	erb :marker, :locals => {:message => "Really your gonna play that level?", :board => ai.play_board.board}
end

post '/squares' do
	ai.players.player1 = params[:XorO]
	ai.players.player2 = ai.players.p2()
	erb :squares, :locals => {:player1 => ai.players.player1, :player2 => ai.players.player2, 
							  :message => "Player 1 is #{ai.players.player1} so Player 2 is #{ai.players.player2} ", :message2 => "", 
							  :current => ai.players.current, :board => ai.play_board.board, :type => ai.players.type, :invaild => ""}
end

post '/game' do
	choice = params[:choice].to_i
	player_marker = ai.players.current_player()
	
	if ai.play_board.square_available?(choice - 1) == true
		ai.play_board.board[choice - 1] = player_marker
		redirect to('/status')
	else
		erb :squares, :locals => {:player1 => ai.players.player1, :player2 => ai.players.player2, 
								  :invaild => "Hey man #{choice} is already taken", :error2 => "Please choose again.",:message => "",:message2 => "", 
								  :current => ai.players.current, :board => ai.play_board.board, :type => ai.players.type}
	end	
end

get '/cpu' do
	sleep 1
	player_marker = ai.players.current_player()
	move = ai.computer_move(ai.level)
	ai.play_board.board[move] = player_marker
	redirect to('/status')
end

get '/status' do
	if ai.play_board.winner?(ai.players.current_player) == true
		redirect to('/win')
	elsif ai.play_board.board_full?() == true
		redirect to('/tie')
	end
	
	ai.players.current = ai.players.change()
	redirect to('/cpu') if ai.players.type == "1" && ai.players.current == 2
	erb :squares, :locals => {:player1 => ai.players.player1, :player2 => ai.players.player2, 
							  :invaild => "", :message => "", :message2 => "", 
							  :current => ai.players.current, :board => ai.play_board.board, :type => ai.players.type}	
end

get '/win' do
	erb :gameover, :locals => {:message => "!!! Hey player #{ai.players.current} you win!!!", :board => ai.play_board.board}
end

get '/tie' do
	erb :gameover, :locals => {:message => "It's a tie.", :board => ai.play_board.board}
end

post '/new' do
	ai = AI.new()
	# game_board = Board.new()
	# players = Players.new()
	redirect to('/tictactoe')
end