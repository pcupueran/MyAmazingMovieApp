MyAmazingMovieApp::App.controllers :movies do

  #Create
  get :new do
    @movie = Movie.new
    render 'movie/new_movie.haml'
  end

  post :create, :map => '/movies' do
    @movie  = Movie.get_film_info(params[:movie][:title])

    flash[:message] = "#{@movie.title} has been created"
    redirect url_for(:movies, :index)
  end

  #Read
  get :index do
    # session[:user] = "Patty"
    @movies = Movie.all
    render 'movie/list_movies.haml'
  end

  get :show, :with => :slug do
    @movie = Movie.find_by(:slug => params[:slug])#model
    if @movie
      render 'movie/show.haml'#view
    else
      404
    end
  end

  #Update

  get :edit, :map => '/movies/:movie_id/edit' do
    @movie = Movie.find(params[:movie_id])
    render 'movie/edit.haml'
  end

  put :update, :with => :movie_id  do

    @movie = Movie.find(params[:movie_id])
    flash[:message] = "#{@movie.title} has been updated"
    @movie.update(params[:movie])

    redirect url_for(:movies, :show, :slug => @movie.slug)
  end

  #Delete
  delete :delete, :map => '/movies/:movie_id' do
    @movie = Movie.find(params[:movie_id])
    @movie.destroy
    flash[:message] = "#{@movie.title} has been deleted"
    redirect url_for(:movies, :index)
  end

end
