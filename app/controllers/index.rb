get '/' do
  test = CLIENT.home_timeline
  string = test.reduce("") do |string, t|
    string += t.text
  end

  string
end

get '/:twitter_user' do
  username = params[:twitter_user]
  user = TwitterUser.find_by(username: username)

  if check_if_cached(user)
    @tweets = user.tweets.limit(10)
    @cached = true
    return erb :tweets
  end

  tweets = CLIENT.user_timeline(username)

  if user.nil?
    user_info = tweets[0].user
    user = TwitterUser.create(username: user_info.screen_name.downcase,
                                       twitter_id: user_info.id.to_s,
                                       name: user_info.name)
  end

  tweets.each do |tweet|
    tweet = user.tweets.find_by(tweet_id: tweet.id.to_s)
    if tweet
      tweet.update(updated_at: Time.now)
    else
      user.tweets.create(content: tweet.text,
                       tweet_time: tweet.created_at,
                       tweet_id: tweet.id.to_s)
    end
  end

  @tweets = user.tweets.limit(10)
  @cached = false
  erb :tweets
end
