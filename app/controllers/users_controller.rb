class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end
    
    def create
       @user = User.new(user_params)
       if @user.save
           flash[:notice] = "Welcome #{@user.username}! You have successfully signed up!"
           session[:user_id] = @user.id
           redirect_to articles_path
       else
           render 'new'
       end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:notice] = "Your profile was successfully edited!"
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end
    
    def destroy
        @user.destroy
        flash[:notice] = "Account and all associated articles have been deleted"
        if !current_user.admin?
            session[:user_id] = nil
            redirect_to articles_path
        else
            redirect_to users_path
        end
    end

    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if @user != current_user && !current_user.admin?
            flash[:alert] = "You can not edit/delete someone else's profile"
            redirect_to @user
        end
    end

    
end