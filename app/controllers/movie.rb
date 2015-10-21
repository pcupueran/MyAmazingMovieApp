MyAmazingMovieApp::App.controllers :movies do

  get '/:slug' do
    @movie = Movie.find_by(:slug => params[:slug])#model
    if @movie
      render 'movie/show'#view
    else
      404
    end
  end
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end


end
