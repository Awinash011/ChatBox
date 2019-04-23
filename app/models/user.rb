class User < ApplicationRecord

  scope :valid_users, -> {where('created_at < ?', Time.now - 1.minutes)} 

end