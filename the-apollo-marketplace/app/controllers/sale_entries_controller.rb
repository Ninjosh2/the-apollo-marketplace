class SaleEntriesController < ApplicationController
    #shows all of the sales post that are made for every user.
    get '/sales' do
        @sale_entries = SaleEntry.all
        erb :'/sale_entries/index'
    end
    #the route that shows the 'new' page.
    get '/sale_entries/new' do
        erb :'/sale_entries/new'
    end
    #verifies that a user is logged in. Also another if/else block
    #that will redirect the user to their post. If it's not the logged user,
    #the it will redirect the user back to the 'new' page.
    post '/sale_entries' do
        if !logged_in?
            redirect '/'
        end
        if params[:item] && params[:description] && params[:price] != ""    
            @sale_entry = SaleEntry.create(item: params[:item], description: params[:description], price: params[:price], user_id: current_user.id)
            redirect "/sale_entries/#{@sale_entry.id}"
        else
            redirect '/sale_entries/new'
        end
    end
    #show route for sale entry for that user.
    get '/sale_entries/:id' do
        set_sale_entry
        erb :'/sale_entries/show'
    end
    #this will send us to the sale_entries/edit erb, and have #an edit form
    #if it's not the signed in user, but user is signed in, then redirect back #to that user's edit page. 
    #if no user is signed in, the redirect back to '/' 
    get '/sale_entries/:id/edit' do
        set_sale_entry
        if logged_in?
            if allowed_to_edit?(@sale_entry)
                erb :'/sale_entries/edit'
            else
                redirect "users/#{current_user.id}"
             end  
        else
            redirect '/'
        end 
    end
    #anything that is updated through the edit page, will be sent throught the
    #block here. Once verified, fire the user back to the user's page with 
    #updated informaton.
    #same as before if it's not the signed in user, but user is signed in, then #redirect back #to that user's edit page. 
    #if no user is signed in, the redirect back to '/' 
      patch '/sale_entries/:id' do
        set_sale_entry
        if logged_in?
            if @sale_entry.user == current_user && params[:item]; params[:description]; params[:price] != ""
                @sale_entry.update(item: params[:item], description: params[:description], price: params[:price])
                redirect "/sale_entries/#{@sale_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
      end

    delete '/sale_entries/:id' do
        set_sale_entry
        if allowed_to_edit?(@sale_entry)
            @sale_entry.destroy
            redirect '/sales'
        else
            redirect '/sales'
        end
    end

    private
        def set_sale_entry
        @sale_entry = SaleEntry.find(params[:id])
    end
end