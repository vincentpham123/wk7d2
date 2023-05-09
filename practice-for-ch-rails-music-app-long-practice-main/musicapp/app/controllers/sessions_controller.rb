class SessionsController < ApplicationController

    def new 
    end
    def create 
        user = User.find_by_credentials(params[:user][:username],params[:user][:password])
        if user.nil?
            #store error for next request
            flash.now[:errors] = ['invalid username or password']
            render :new 
        else
            login!(user)
            redirect_to user_url(user)
        end
    end

    def destroy 
        logout! 
        redirect_to new_session_url
    end
    
end
