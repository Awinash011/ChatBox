namespace :reset_database do

  desc "TODO"
  task database_reset: :environment do
    Message.destroy_all
    Conversation.destroy_all
    User.destroy_all
    # session[:user_id] = nil
    # cookies[:user_id] = nil
  end

end