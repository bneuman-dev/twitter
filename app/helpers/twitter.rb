helpers do
  def check_if_cached(user)
    return false if user.nil?
    time = user.tweets.last.updated_at
    (Time.now - time) < 100
  end
end
