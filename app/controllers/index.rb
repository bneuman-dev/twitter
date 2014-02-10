get '/refresh_tweets' do
  tweets = CLIENT.user_timeline(params["username"])

  user_info = tweets[0].user
  user = TwitterUser.find_or_create_by(username: user_info.screen_name.downcase,
                                       twitter_id: user_info.id.to_s,
                                       name: user_info.name)

  tweets.each do |tweet|
    cached_tweet = user.tweets.find_by(tweet_id: tweet.id.to_s)
    if cached_tweet
      cached_tweet.update(updated_at: Time.now)
    else
      user.tweets.create(content: tweet.text,
                       tweet_time: tweet.created_at,
                       tweet_id: tweet.id.to_s)
    end
  end

  @tweets = user.tweets.limit(10)
  @cached = false
  erb :tweets, :layout => false
end


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
    erb :tweets

  else
    @username = username
    erb :waiting
  end
end

