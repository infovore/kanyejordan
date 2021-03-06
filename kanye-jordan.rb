#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
Bundler.require(:default)

PATH_PREFIX = File.expand_path(File.dirname(__FILE__))

config = YAML.parse(File.read(PATH_PREFIX + "/creds.yml"))

%w{consumer_key consumer_secret access_token access_token_secret}.each do |key|
  Object.const_set(key.upcase, config["config"][key].value)
end

DB = Sequel.sqlite("#{File.dirname(__FILE__)}/kanye_jordan.db")

highest_tweet = DB[:read_tweets].order(:id).last
if highest_tweet
  highest_tweet_id = highest_tweet[:id].to_i
else
  highest_tweet_id =1 
end

Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = ACCESS_TOKEN
  config.oauth_token_secret = ACCESS_TOKEN_SECRET
end

tweets = Twitter.user_timeline("kanyewest", :count => 50, :since_id => highest_tweet_id)
tweets.reverse.each do |tweet|
  newtext = "Liz Lemon, #{tweet.text}"
  if newtext.size > 140
    newtext = newtext[0,137] + "..."
  end
  Twitter.update(newtext)
  #puts tweet.id.to_s + ": " + newtext
  DB[:read_tweets].insert(:id => tweet.id,
                          :created_at => Time.now)
end
