module MyAmazingMovieApp
  class App < Padrino::Application
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    before do
      unless request.path == '/login' || session[:logged_in]
        redirect url_for(:login)
      end
    end

    get :login do
      render '../login.haml'
    end

    post :login do
      password = "cool_beans"
      if password == params[:password]
        session[:logged_in] = true
        flash[:message] = "You have successfully logged in"
        redirect url_for(:movies, :index)
      else
        flash[:message] = "Wrong password. Please try again!"
        redirect url_for(:login)
      end
    end
  end
end
