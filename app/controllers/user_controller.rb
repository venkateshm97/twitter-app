class UserController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def show
    print "\nparams = #{params}\n"
    id = params[:id]
    @user = User.find(id.to_i)
    @is_following = @user.followers.pluck(:follow_to).include?(current_user.id)
    @tweet = Tweet.joins(:user).where(user_id: @user.id).order('created_at DESC').select('email, tweets.*')
    @followers = User.where(id: @user.followers.pluck(:follow_to))
    @following = User.where(id:Follower.where(follow_to: @user.id).pluck(:user_id))
  end

  def follow
    print "\nparams = #{params}\n"
    if params[:status] == 'follow'
      follow_to = params[:follow_to]
      @follow = Follower.new(follow_to: current_user.id, user_id: follow_to)
       if @follow.save
        redirect_to '/', notice: 'Successfully Following'
      else
        redirect_to '/', notice: 'Already Following'
      end
    else
      follow_to = params[:follow_to]
      @follow = Follower.find_by(follow_to: current_user.id, user_id: follow_to)
      if @follow and @follow.delete()
        redirect_to '/', notice: 'Successfully Unfollow'
      else
        redirect_to '/', notice: 'Already Unfollowing'
      end
    end
  end
end
