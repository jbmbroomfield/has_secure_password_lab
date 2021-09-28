class UsersController < ApplicationController

    def new
        if current_user
            redirect_to users_home_path
        end
        @user = User.new
    end

    def create
        if user_params[:password] == user_params[:password_confirmation]
            @user = User.create(user_params)
            session[:user_id] = @user.id
            redirect_to users_home_path
        else
            redirect_to new_user_path
        end
    end

    def home
        if current_user == nil
            redirect_to new_user_path
        else
            @user = current_user
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end

end