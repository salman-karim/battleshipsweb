require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
enable :sessions

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index
  end

  get '/new_game' do
    if (params[:name] == '' || params[:name] == nil)
      erb :new_game
    else
      session[:name] = params[:name]
      redirect "/start_game"
    end
  end

  get '/start_game' do
    unless defined?($game)
      $game = Game.new Player, Board
      session[:player] = :player1
      erb :start_game
    else
      session[:player] = :player2
      erb :start_game
    end
  end

  def player
    if session[:player] == :player1
      $game.player_1
    else
      $game.player_2
    end
  end

  get '/place_ships' do
    unless (params[:ship] == '' || params[:ship] == nil)
      begin
        player.place_ship Ship.send(params[:ship]), params[:coords].upcase, params[:direction]
      rescue RuntimeError => @error
      end
    end
      @board = $game.own_board_view(player)
      erb :place_ships
  end

  get '/bomb' do
    unless (params[:coords] == nil)
      begin
        @hit_miss = player.shoot params[:coords].to_sym
        @winstatus = $game.has_winner?
      rescue RuntimeError => @error
      end
    end
    @board = $game.opponent_board_view(player)
    if @winstatus
      redirect "/winnerpage"
    else
      erb :bomb
    end
  end

  get '/winnerpage' do
    @p1wins = $game.player_1.winner?
    erb :winner
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
