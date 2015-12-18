require 'sinatra'
require_relative "NewGame.rb"
require_relative "ai.rb"
require_relative"gameplayers.rb"
require_relative"gameboard.rb"




get '/tictactoe' do
	board = Gameboard.new
	erb :OneplayerorTwoplayer, :locals => {:message => "",
										   :board => @board}
end





post '/tictactoe' do
	player1_details= [params[:player1], params[:difficulty]]
	player2_details= [params[:player2], params[:difficulty]]
	players_details= [player1_details, player2_details]
	type= params[:typeofgame]
	
game = Game.new(player1_details,player2_details)
	if type == "1"
	erb :OneplayerorTwoplayer, :locals => {:message => "You Chose to play a 1 player game", 
										   :board => @board}
	else
	erb :marker, :locals => {:message => "You Chose to play a 2 player game", 
							 :board => @board}
	end
end


post '/marker' do
		game.difficulty = params[:difficulty] 
		if game.players.type == "1"
		erb :marker, :locals => {:message => "You chose Easy.Really your gonna play that level?", 
								 :board => game.play_board.board}
		elsif game.players.type == "2"
		erb :marker, :locals => {:message => "You chose Medium.Really your gonna play that level?", 
								 :board => game.play_board.board}
		elsif game.players.type == "3"						 
		erb :marker, :locals => {:message => "You chose Hard.Really your gonna play that level?", 
								 :board => game.play_board.board}						 
		end						 
end

post '/squares' do
	player1_details = params[:XorO]
	player2_details = params[:XorO]
	make_current_player = "X" || "O"
	erb :squares, :locals => {:player1 => player1_details, 
							  :player2 => player2_details, 
							  :message => "Player 1 is #{player1_details} so Player 2 is #{player2_details} ", 
							  :message2 => "", 
							  :current => make_current_player, 
							  :board => @board, 
							  :invaild => ""}
end

post '/game' do
	choice = params[:choice].to_i
	
	
	if Game.valid_square?(choice) == true
	   Game.next_marker = make_current_player
		redirect to('/status')
	else
		erb :squares, :locals => {:player1 => game.players.player1, 
								  :player2 => game.players.player2, 
								  :invaild => "Hey man #{choice} is already taken", 
								  :error2 => "Please choose again.",
								  :message => "",
								  :message2 => "", 
								  :current => game.players.current, 
								  :board => game.play_board.board, 
								  :type => game.players.type}
	end	
end

get '/cpu' do
	sleep 1
	player_marker = players.current_player()
	move = game.computer_move(game.level)
	game.play_board.board[move] = player_marker
	redirect to('/status')
end

get '/status' do
	if play_board.winner?(game.players.current_player) == true
		redirect to('/win')
	elsif play_board.board_full?() == true
		redirect to('/tie')
	end
	
	game.players.current = game.players.change()
	redirect to('/cpu') if game.players.type == "1" && game.players.current == 2
	erb :squares, :locals => {:player1 => game.players.player1, 
							  :player2 => game.players.player2, 
							  :invaild => "", 
							  :message => "", 
							  :message2 => "", 
							  :current => game.players.current, 
							  :board => game.play_board.board, 
							  :type => game.players.type}	
end

get '/win' do
	erb :gameover, :locals => {:message => "!!! Hey player #{game.players.current} you win!!!", 
							   :board => game.play_board.board}
end

get '/tie' do
	erb :gameover, :locals => {:message => "It's a tie.", 
							   :board => game.play_board.board}
end

post '/new' do
	game = Game.new(Gameboard.new,player1type,player2type)
	# game_board = Board.new()
	# players = Players.new()
	redirect to('/tictactoe')
end