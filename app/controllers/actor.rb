MyAmazingMovieApp::App.controllers :actors do

  get :new do
    @actor = Actor.new
    render 'actor/new_actor'
  end

  get :create do
    @actor = Actor.get_actors_info(params[:name])
  end

  get :index do
    @actors = Actor.all
    render 'actor/list_actors'
  end

end
