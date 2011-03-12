#!/usr/bin/env ruby
require 'rubygems'
require 'twitter'
require 'yaml'
require 'json'

PATH_PREFIX = File.expand_path(File.dirname(__FILE__))

config = YAML.parse(File.read(PATH_PREFIX + "/creds.yml"))

%w{consumer_key consumer_secret access_token access_token_secret}.each do |key|
  Object.const_set(key.upcase, config["config"][key].value)
end

highestcount = File.read(PATH_PREFIX + "/highest")

Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = ACCESS_TOKEN
  config.oauth_token_secret = ACCESS_TOKEN_SECRET
end

tweets = Twitter.user_timeline(:screen_name => "kanyewest", :count => 50, :since_id => highestcount)

tweets.reverse.each do |tweet|
  newtext = "Liz Lemon, #{tweet.text}"
  if newtext.size > 140
    newtext = newtext[0,137] + "..."
  end
  Twitter.update(newtext)
  highestcount = tweet.id
  File.open(PATH_PREFIX + "/highest", "w") {|f| f.write(highestcount)}
end

