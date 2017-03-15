class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end
  
  def create
    friend = User.find(params[:friend_id])
    
    params[:user_id] = current_user.id
    
    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
    redirect_to root_path
  end
  
  def destroy
    @following = Friendship.find(params[:id])
    
    if @following.destroy
      flash[:notice] = "#{@following.friend.full_name} unfollowed"
    else
      flash.now[:alert] = "Something went wrong"
    end
    redirect_to user_exercises_path(current_user)
  end
  
  private
    
    def friendship_params
      params.permit(:user_id, :friend_id)
    end
end