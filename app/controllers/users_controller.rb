class UsersController < ApplicationController

 # =============CALLBACKS=====================
  before_action :find_user, only: [:update]  
  before_action :authenticated_user!, only: [:update, :edit]

 # ==============CREATE========================
 def new
       @user = User.new
 end
   
   def create
       @user = User.new user_params

       if @user.save
         session[:user_id] = @user.id
         flash.notice = "Signed up!"
         redirect_to root_path
       else
         render :new, status: 303
       end 
   
   end

 private

 def find_user
   @user = User.find_by_id params[:id]
 end

 def user_params
   params.require(:user).permit(:first_name, :last_name, :email, :password)
 end
end
