MyAmazingMovieApp::App.controllers :movies do
  # enable :sessions

  # before do
  # # binding.pry
  #   halt 401 unless session[:password]
  #   # halt 401 unless params[:cool_beans]
  # end
  # post '/login' do
  #   password = "cool_beans"
  #   if params[:password] == password
  #     session[:password] = true
  #     redirect '/movies'
  #   end
  # end

  #Create
  get '/new' do
    render 'movie/new_movie'
  end

  post '/create' do
    Movie.create!(params[:movie])
  end

  #Read
  get '/' do
    session[:user] = "Patty"
    @movies = Movie.all
    render 'movie/list_movies'
  end

  get '/:slug' do
    @movie = Movie.find_by(:slug => params[:slug])#model
    if @movie
      render 'movie/show'#view
    else
      404
    end
  end

  #Update

  get '/:movie_id/edit' do
    render 'movie/edit'
  end

  post '/:movie_id/update' do
    Movie.update(params[:movie_id], params[:movie])
  end

  #Delete
  post '/:movie_id/delete' do
    @movie = Movie.find(params[:movie_id])
    @movie.destroy
  end

end
