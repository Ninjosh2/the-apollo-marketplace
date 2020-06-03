class SaleEntriesController < ApplicationController

    get '/sale_entries/new' do
        erb :'/sale_entries/new'
        
    end




    post '/sale_entries' do

        if !logged_in?
            redirect '/'
        end

        if params[:sale_entries] !=''
            @sale_entry = SaleEntry.create(item: params[:item], description: params[:description], price: params[:price], user_id: current_user.id)
            redirect "/sale_entries/#{@sale_entry.id}"
        else
            redirect '/sale_entries/new'
        end




    end
   


end