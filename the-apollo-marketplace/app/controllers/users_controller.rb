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
        erb :signup
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:pasword] != ""
            @user = User.create(params)
            redirect "/users/#{@user.id}"
        else
            
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        
        erb :'/users/show'
    end

end