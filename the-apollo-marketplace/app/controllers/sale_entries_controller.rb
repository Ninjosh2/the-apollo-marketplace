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
        set_sale_entry
        erb :'/sale_entries/show'
    end

    #this will send us to the sale_entries/edit erb, and have #an edit form
    get '/sale_entries/:id/edit' do
        set_sale_entry
        if logged_in?
            if @sale_entry.user == current_user
                erb :'/sale_entries/edit'
            else
                redirect "users/#{current_user.id}"
             end  
        else
            redirect '/'
        end 
    end

      patch '/sale_entries/:id' do
        set_sale_entry
        if logged_in?
            if @sale_entry.user == current_user
                @sale_entry.update(item: params[:item], description: params[:description], price: params[:price])
                redirect "/sale_entries/#{@sale_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
      end

      private
      def set_sale_entry
        @sale_entry = SaleEntry.find(params[:id])
      end

end