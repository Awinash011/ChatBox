class HomeController < ApplicationController

  def index_two
    @all_users = User.all
    if (ENV["USER_COUNT"].to_i <= @all_users.count) && (ENV["USER_TIME"].to_i <= Time.now.to_i-User.first.created_at.to_i)
      @users = User.all.where.not(id: current_user)
      @conversation = Conversation.last 
      @conversation = Conversation.create unless @conversation
    else
      render :js => "window.location = '/home/index_one'"
    end
  end

  def index_one
    if session[:user_id]
      unless current_user
        set_user_session
      end    
    else
      set_user_session      
    end
    @valid_users = User.valid_users #.where.not(id: current_user.id)
    # @other_users = User.where.not(id: @valid_users.pluck(:id))
    @all_users = User.all
  end

  def reset_all
    Message.destroy_all
    Conversation.destroy_all
    User.destroy_all
    session[:user_id] = nil
    cookies[:user_id] = nil
    redirect_to root_path
  end

  private

  def set_user_session
    @user = User.create(user_name: "User_#{Time.now.to_i}")
    session[:user_id] = @user.id
    cookies[:user_id] = {
      :value => @user.id,
      :expires => Time.now + 15.minutes
    }
  end

end