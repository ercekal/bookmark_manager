require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookMark < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @error_msg = flash[:notice]
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
   link = Link.new(url: params[:url], title: params[:title])
   tags = params[:tags].split(' ')
   tags.each do |tag|
      single_tag = Tag.first_or_create(name: tag)
      link.tags << single_tag
    end
   link.save
   redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @error_msg = flash[:notice]
    @current_email = session[:user_email]
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    session[:user_email] = params[:email]
    if user.save
      redirect '/links'
    else
      flash[:notice] = user.errors.full_messages.join(", ")
      redirect '/users/new'
    end
  end

  get '/users/signin' do
    @error_msg = flash[:notice]
    erb :'users/signin'
  end

  post '/users/signin' do
    user = User.check_password(params[:email], params[:password])
      if user
      session[:user_id] = user.id
      redirect '/links'
      else
      flash[:notice] = ['Username or password is not correct']
      redirect '/users/signin'
      end
    end

    get '/users/signout' do
      session.clear
      flash[:notice] = ['Goodbye!']
      redirect '/links'
    end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
