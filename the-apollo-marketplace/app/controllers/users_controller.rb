class UsersController < ApplicationController
    #the login route I want is here
    get '/login' do
        erb :login
    end
    #creates a session for the user that's logged in.
    post '/login' do
        @user = User.find_by(email: params[:email])
        if  @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.name}!"
            redirect "users/#{@user.id}"
        else
            #binding.pry
            flash[:error] = "Invalid input. Please try again."
            redirect '/login'
        end
    end
    #the signup route is here!
    get '/signup' do
        erb :signup
    end

    post '/users' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Account created! Welcome, #{@user.name}!"
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Invalid account creation: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end