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
    render 'movie/new_movie'
  end

  post :create do
    @movie  = Movie.get_film_info(params[:title])
    redirect '/movies'
  end

  #Read
  get :index do
    # session[:user] = "Patty"
    @movies = Movie.all
    render 'movie/list_movies'
  end

  get :show, :with => :slug do
    @movie = Movie.find_by(:slug => params[:slug])#model
    if @movie
      render 'movie/show'#view
    else
      404
    end
  end

  #Update

  get :edit, :map => '/movies/movie_:id/edit' do
    @movie = Movie.find(params[:movie_id])
    render 'movie/edit'
  end

  post :update, :with => :movie_id do
    @movie_update = {:title => params[:title],
      :year => params[:year],
      :description => params[:description]
    }
    @movie = Movie.find(params[:movie_id])
    @movie.update(@movie_update)

    redirect "movies/#{@movie.slug}"
  end

  #Delete
  post :delete, :with => :movie_id do
    @movie = Movie.find(params[:movie_id])
    @movie.destroy
    redirect '/movies'
  end

end
