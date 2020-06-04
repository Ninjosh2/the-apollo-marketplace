class SaleEntriesController < ApplicationController

    get '/sale_entries/new' do
        erb :'/sale_entries/new'
    end

    post '/sale_entries' do

        if !logged_in?
            redirect '/'
        end

        if params[:item] != "" 
            @sale_entry = SaleEntry.create(item: params[:item], description: params[:description], price: params[:price], user_id: current_user.id)
            redirect "/sale_entries/#{@sale_entry.id}"
        else
            redirect '/sale_entries/new'
        end
    end

        #show route for sale entry
    get '/sale_entries/:id' do
        @sale_entry = SaleEntry.find(params[:id])
        erb :'/sale_entries/show'
    end

    #this will send us to the sale_entries/edit erb, and have #an edit form
    get '/sale_entries/:id/edit' do
        erb :'/sale_entries/edit'
      end

end