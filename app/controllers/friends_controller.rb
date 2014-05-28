class FriendsController < ApplicationController

  def add_friend
    friend = User.find_by_username(params[:friend])
    user = logged_in_user
    Friendship.add_friendship(user.id, friend.id, params[:friend_category].to_i)
    render(:text => "Friend request sent")
  end

  def remove_friend
    friend = User.find_by_username(params[:friend])
    @user = logged_in_user
    @user_detail = UserDetail.find_by_user_id(@user.id)
    Friendship.remove_friendship(@user.id, friend.id)
    @friend_requests = Friendship.search_friend_request(@user.id)
    @friends = Friendship.search_all_friends(@user.id, Friendship::STATUS_ACCEPTED)
    render(:partial => "users/my_friends_show_partial")
  end

  def accept_friend
    friend = User.find_by_username(params[:friend])
    @user = logged_in_user
    Friendship.accept_friendship(@user.id, friend.id, params[:friend_category].to_i)
    @friend_requests = Friendship.search_friend_request(@user.id)
    @friends = Friendship.search_all_friends(@user.id, Friendship::STATUS_ACCEPTED)
    render(:partial => "users/my_friends_show_partial")
  end

  def reject_friend
    friend = User.find_by_username(params[:friend])
    @user = logged_in_user
    Friendship.reject_friendship(@user.id, friend.id)
    @friend_requests = Friendship.search_friend_request(@user.id)
    @friends = Friendship.search_all_friends(@user.id, Friendship::STATUS_ACCEPTED)
    render(:partial => "users/my_friends_show_partial")
  end

end
