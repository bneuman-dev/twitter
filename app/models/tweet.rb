class Tweet < ActiveRecord::Base
  validates :tweet_id, :uniqueness => true
  belongs_to :tweeter, class_name: "TwitterUser"
  # Remember to create a migration!
end
