class BookMark < Sinatra::Base

  get '/users/new' do
    # @error_msg = flash[:notice]
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
    # @error_msg = flash[:notice]
    erb :'users/signin'
  end

  post '/users/signin' do
    user = User.check_password(params[:email], params[:password])
      if user
      session[:user_id] = user.id
      redirect '/links'
      else
      flash[:notice] = 'Username or password is not correct'
      redirect '/users/signin'
      end
    end

    get '/users/signout' do
      session.clear
      flash[:notice] = 'Goodbye!'
      redirect '/links'
    end
end
