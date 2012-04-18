Kanye Jordan: A Satirical Twitterbot
====================================

kanye-jordan.rb retweets anything Kanye West says, with "Liz Lemon, " prefixed in front of it. This is nominally amusing if you like a) 30 Rock and b) Kanye's marvellous twitter account.

This is shared not so you can run your own; more so that the principles of how this works are made clear. Also: how to separate out OAuth configuration variables from a script that sends tweets - ie, so you can redistribute code but not credentials.

Configuration
-------------

* Fill out your own creds.yml with the Twitter OAuth credentials you've acquired when you created an application on (developer.twitter.com)
* Put all these files on a server.
* run migration.rb to create a sqlite database
* Run kanye-jordan.rb (or whatever your file is called) periodically. It will make tweets.
* That's it.
