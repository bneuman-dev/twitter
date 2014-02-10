class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.string :tweet_time
      t.string :tweet_id
      t.string :tweeter_id
      t.timestamps
    end
  end
end
