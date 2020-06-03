class UsersController < ApplicationController

    #the login route I want is here
    get '/login' do
        erb :login
        
    end


    #creates a session for the user that's logged in.
    post '/login' do
        @user = User.find_by(email: params[:email])
        
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts session
            redirect "users/#{@user.id}"
            
        else
            
        end
        
    end

    #the signup route is here!

    get '/signup' do
        
    end

    get '/users/:id' do
        "user page"
    end

end