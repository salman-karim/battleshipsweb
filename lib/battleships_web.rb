require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index
  end

  get '/new_game' do
    if (params[:name] == '' || params[:name] == nil)
      erb :new_game
    else
      @name = params[:name]
      redirect '/start_game'
    end
  end

  get '/start_game' do
    erb :start_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end