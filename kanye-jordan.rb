#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'twitter'
require 'yaml'
require 'json'

config = YAML.parse(File.read("creds.yml"))

%w{consumer_key consumer_secret access_token access_token_secret}.each do |key|
  Object.const_set(key.upcase, config["config"][key].value)
end

puts CONSUMER_KEY
puts CONSUMER_SECRET
puts ACCESS_TOKEN
puts ACCESS_TOKEN_SECRET
