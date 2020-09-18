class SaleEntriesController < ApplicationController

    get '/sale_entries' do
        @sale_entries = SaleEntry.all
        erb :'/sale_entries/index'
    end

    get '/sale_entries/new' do
        erb :'/sale_entries/new'
    end

    post '/sale_entries' do
        redirect_if_not_logged_in
        if params[:item] && params[:description] && params[:price] != ""
            flash[:message] = "Post Created!"  
            @sale_entry = SaleEntry.create(item: params[:item], description: params[:description], price: params[:price], user_id: current_user.id)
            redirect "/sale_entries/#{@sale_entry.id}"
        else
            flash[:error] = "Oops! Please fill out all fields to submit the sale."
            redirect '/sale_entries/new'
        end
    end

    get '/sale_entries/:id' do
        set_sale_entry
        if @sale_entry
            erb :'/sale_entries/show'
        else
            flash[:error] = "Oops! This doesn't exist."
            redirect to '/sale_entries'
        end
        
        
    end

    get '/sale_entries/:id/edit' do
        set_sale_entry
        if @sale_entry
            erb :'/sale_entries/show'
        else
            flash[:error] = "Oops! This doesn't exist."
            redirect to "/users/#{current_user.id}"
        end
        redirect_if_not_logged_in
        if allowed_to_edit?(@sale_entry)
            erb :'/sale_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end
    end

    patch '/sale_entries/:id' do
        set_sale_entry
        redirect_if_not_logged_in
            if @sale_entry.user == current_user && params[:item]; params[:description]; params[:price] != ""
                @sale_entry.update(item: params[:item], description: params[:description], price: params[:price])
                redirect "/sale_entries/#{@sale_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
    end

    delete '/sale_entries/:id' do
        set_sale_entry
        if allowed_to_edit?(@sale_entry)
            @sale_entry.destroy
            flash[:message] = "Post deleted!"
            redirect '/sale_entries'
        else
            redirect '/sale_entries'
        end
    end

    private
        def set_sale_entry
        @sale_entry = SaleEntry.find_by(id: params[:id])
    end
end