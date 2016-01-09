require 'sinatra'
require_relative "random.rb"
require_relative "negamax.rb"
require_relative "medium.rb"
require_relative "moderately_easy.rb"
require_relative "simple.rb"
require_relative "gameboard.rb"
require_relative "gameplayers.rb"

enable :sessions

ai = ""

play_board = Gameboard.new()
players = Gameplayers.new()

# get '/' do 
	# erb :home, :locals => {}	
# end

# get '/rules' do
	# erb :rules, :locals => {}
# end





get '/tictactoe' do
	session[:playboard] = play_board
	erb :OneplayerorTwoplayer, :locals => {:message => "Lets Play Some Tic-Tac-Toe", :board => session[:playboard].board}
end

post '/tictactoe' do
	session[:players] = players
	session[:players].type = params[:gametype]
	session[:gametype] = params[:gametype]
	
	if session[:gametype] == "1"
		erb :howhard, :locals => {:message => "You Chose a 1 Player VS the Computer Game", :board => session[:playboard].board}
	else
		erb :marker, :locals => {:message => "You Chose a 2 player game", :board => session[:playboard].board}
	end
end

post '/marker' do
		session[:ai] = ai
		session[:players].level = params[:level] 
		session[:level] = params[:level]
		if session[:level] == "easy"
		session[:ai] = Easy.new(session[:playboard])
			erb :marker, :locals => {:message => "Really your gonna play EASY??", :board => session[:playboard].board}
		elsif session[:level] =="mild"
		session[:ai] = ModEasy.new(session[:playboard], session[:players])
			erb :marker, :locals => {:message => "Really Mild?? Mild is a Sauce not a level.", :board => session[:playboard].board}
		elsif session[:level] =="simple"
		session[:ai] = Simple.new(session[:playboard], session[:players])
			erb :marker, :locals => {:message => "Simple?? Comon man Try a harder level", :board => session[:playboard].board}
		elsif session[:level] == "medium"
		session[:ai] = Medium.new(session[:playboard], session[:players])
			erb :marker, :locals => {:message => "MEDIUM is cool but how about HARD??", :board => session[:playboard].board}
		else 	
		session[:ai] = Negamax.new(session[:playboard],session[:players])
			erb :marker, :locals => {:message => "Hard?? You know it cant be beat right?", :board => session[:playboard].board}

		end
end

post '/squares' do
	
	session[:XorO] = params[:XorO]
	session[:players].player1 = params[:XorO]
	session[:players].player2 = session[:players].p2()
	
	erb :squares, :locals => {:p1 => session[:players].player1, :p2 => session[:players].player2, 
							  :invaild => "", :message2 => "Player 1 is #{session[:players].player1} & Player 2 is #{session[:players].player2} ", 
							  :current => session[:players].current, :board => session[:playboard].board, :type => session[:players].type}
end

post '/game' do

	session[:choice] = params[:choice].to_i
	choice = params[:choice].to_i
	player_marker = session[:players].current_player()
	
	if session[:playboard].square_available?(choice - 1) == true
		session[:playboard].board[choice - 1] = player_marker
		redirect to('/status')
	else
		erb :squares, :locals => {:p1 => session[:players].player1, 
								  :p2 => session[:players].player2, 
								  :invaild => "Hey Player #{session[:players].current} #{choice} is already taken", 
								  :message2 => "Please choose again.", 
								  :current => session[:players].current, 
								  :board => session[:playboard].board, 
								  :type => session[:players].type}
	end	
end


get '/computerai' do
		player_marker = session[:players].current_player()

		move = session[:ai].computer_move()

	session[:playboard].board[move] = player_marker
	redirect to('/status')
end

get '/status' do
	if session[:playboard].winner?(session[:players].current_player) == true
		redirect to('/win')
	elsif session[:playboard].board_full?() == true
		redirect to('/tie')
	end
	
	session[:players].current = session[:players].change()
	if session[:players].type == "1" && session[:players].current == 2
	 redirect to('/computerai') 
	 else
		redirect to('/aimove')
	end
end

get '/aimove' do

	session[:players].type == "1" && session[:players].current == 1
		erb :squares, :locals => {:p1 => session[:players].player1, 
							  :p2 => session[:players].player2, 
							  :invaild => "", 
							  :message2 => "", 
							  :current => session[:players].current, 
							  :board => session[:playboard].board, 
							  :type => session[:players].type}	
end



get '/win' do
	erb :gameover, :locals => {:message => "Player #{session[:players].current} wins!!! & Player #{session[:players].change()} Sucks", 
							   :board => session[:playboard].board}
end

get '/tie' do
	erb :gameover, :locals => {:message => "Player #{session[:players].current} & Player #{session[:players].change()} TIE ..... Boooo You both suck", 
							   :board => session[:playboard].board}
end


post '/new' do
	play_board = Gameboard.new()
	players = Gameplayers.new()
	ai_initi = false
	redirect to('/tictactoe')
end