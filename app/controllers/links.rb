class BookMark < Sinatra::Base

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
end
