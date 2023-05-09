class UsersController < ApplicationController

    def new
        @user = User.new 
    end

    def create 
        debugger
        @user = User.new(user_params)
        if @user.save 
            render :new
        else
            flash[:errors]=@user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
