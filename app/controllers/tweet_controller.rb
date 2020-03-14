class TweetController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
  def index
    @tweet = Tweet.joins(:user).where(user_id: current_user.id).order('created_at DESC').select('email, tweets.*')
    @followers_tweet = Tweet.joins(:user).where(user_id: Follower.where(follow_to: current_user.id).pluck(:user_id)  ).order('created_at DESC').select('email, tweets.*')
    @users = User.all
  end

  def create_tweet
    print "\nparams = #{params}\n"
    message = params[:message]
    @tweet = Tweet.new(message: message, user_id: current_user.id)
    print "\ntweet = #{@tweet.to_json} current user: #{current_user.to_json}\n"
    if @tweet.save
      redirect_to tweet_index_path, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  def new
    @tweet = Tweet.new
  end

  private
  def tweet_params
    params.require(:message)
  end
end
