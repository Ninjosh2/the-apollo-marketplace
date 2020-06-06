class UsersController < ApplicationController

    #the login route I want is here
    get '/login' do
        erb :login
    end
    #creates a session for the user that's logged in.
    post '/login' do
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Hello, #{@user.name}!"
            redirect "users/#{@user.id}"
        else
            #binding.pry
            flash[:message] = "Invalid input. Please try again."
            redirect '/login'
        end
    end
    #the signup route is here!
    get '/signup' do
        erb :signup
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:pasword] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end