require 'sinatra/base'

class Bookmark_manager < Sinatra::Base


  get '/' do
    erb :index
  end

  post '/links' do
    
    redirect '/listed_links'
  end

  get '/listed_links' do
    @links.list
    erb :listed_links
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
