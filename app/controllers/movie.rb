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
  get :new do
    @movie = Movie.new
    render 'movie/new_movie'
  end

  post :create, :map => '/movies' do
    @movie  = Movie.get_film_info(params[:movie][:title])
    redirect url_for(:movies, :index)
  end

  #Read
  get :index do
    # session[:user] = "Patty"
    @movies = Movie.all
    render 'movie/list_movies'
  end

  get :show, :with => :slug do
    @movie = Movie.find_by(:slug => params[:slug])#model
    # binding.pry
    if @movie
      render 'movie/show'#view
    else
      404
    end
  end

  #Update

  get :edit, :map => '/movies/:movie_id/edit' do
    @movie = Movie.find(params[:movie_id])
    render 'movie/edit'
  end

  post :update, :with => :movie_id  do
    # @movie_update = {:title => params[:title],
    #   :year => params[:year],
    #   :description => params[:description]
    # }
    # params[:movie_id]
    @movie = Movie.find(params[:movie_id])
    @movie.update(params[:movie])

    redirect url_for(:movies, :show, :slug => @movie.slug)
  end

  #Delete
  post :delete, :map => '/movies/:movie_id' do
    @movie = Movie.find(params[:movie_id])
    @movie.destroy
    redirect url_for(:movies, :index)
  end

end
