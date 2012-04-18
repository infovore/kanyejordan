#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
Bundler.require(:default)

DB = Sequel.sqlite('kanye_jordan.db')

DB.create_table :read_tweets do
  primary_key :id
  DateTime :created_at
end

