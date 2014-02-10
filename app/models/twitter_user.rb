class TwitterUser < ActiveRecord::Base
  validates :username, :uniqueness => true
  has_many :tweets, foreign_key: :tweeter_id
  # Remember to create a migration!
end
