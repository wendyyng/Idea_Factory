class LikesController < ApplicationController

    def create
        @idea = Idea.find params[:idea_id]
        @like = Like.new(idea: @idea, user: current_user)
      
      if !current_user
        flash[:alert] = "Please sign in first to like an idea!"
      elsif cannot?(:like, @idea)
        flash[:alert] = "You can't like your own idea!"
       elsif @like.save
        flash[:notice] = "Idea liked!"
       else
        flash[:alert] = @like.errors.full_messages.join(", ")
       end
       redirect_to root_path
      end
      
      def destroy
        @like = current_user.likes.find params[:id]
        
        if cannot?(:destroy, @like)
         flash[:alert] = "You can't destroy a like you don't own!"
        elsif @like.destroy
         flash[:notice] = "Idea unliked"
        else
         flash[:alert] = "Couldn't unlike idea"
        end
        redirect_to root_path
      end
      
end
