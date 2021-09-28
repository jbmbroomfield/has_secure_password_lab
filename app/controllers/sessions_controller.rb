class SessionsController < ApplicationController

    def new
        if current_user
            redirect_to users_home_path
        end
    end

    def create
        @user = User.find_by(name: user_params[:name])
        return head(:forbidden) unless @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
    end

    def destroy
        session.delete :user_id
        redirect_to new_user_path
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end



end