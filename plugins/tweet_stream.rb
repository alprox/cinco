require 'twitter'
require 'htmlentities'

class TweetStream
  EVENT_KEY = :twitter_user_stream

  attr_reader :bot, :client

  def initialize(bot)
    @bot = bot
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Conf[:twitter][:consumer_key]
      config.consumer_secret     = Conf[:twitter][:consumer_secret]
      config.access_token        = Conf[:twitter][:access_token]
      config.access_token_secret = Conf[:twitter][:access_token_secret]
    end
  end

  def run

    # keywords
    #track = Conf[:tweetstream][:track].join(',')
    # integers
    follow = Conf[:tweetstream][:follow].join(',')

    bot.loggers.info "Starting filter"
    client.filter(follow: follow) do |object|
    case object
      when Twitter::Streaming::DeletedTweet
         then handle_deleted(object)
      when Twitter::Streaming::StallWarning
         then bot.loggers.error "Stalling!"
      when Twitter::Tweet
         then handle_tweet(object) 
      else
         handle_object(object)
    end

    # otherwise go fuck yourself twitter
    bot.loggers.info "I don't care: #{object.inspect}" 
    end
  rescue => e
    bot.loggers.error "Tweetstream failed!! #{e.inspect} — retry in 120secs."
    sleep 120
    retry
  end

  private
  def handle_tweet(tweet)
    # no retweets or replies please
    if tweet.retweet? or tweet.reply?
      bot.loggers.info "I don't care: #{tweet.user.screen_name}: #{tweet.full_text}"
    else
      text = HTMLEntities.new.decode(tweet.full_text)
      bot.loggers.info "Tweet: #{tweet.inspect}"
      send_to_channel "#{tweet.user.screen_name}: #{text}"
    end
  end

  def handle_deleted(tweet)
    bot.loggers.info "Tweet: #{tweet.inspect}"
    send_to_channel "Poistettu: #{tweet.user_id} #{tweet.id}"
  end

  def handle_object(object)
    bot.loggers.info "Unknown Tweet Object: #{object.inspect}"
  end

  def send_to_channel(text)
    bot.handlers.dispatch(EVENT_KEY, nil, text)
  end

end

module Cinch::Plugins
  class TweetStream
    include Cinch::Plugin

    def initialize(*args)
      super
    end

    listen_to ::TweetStream::EVENT_KEY
    def listen(m, text)
      Channel(Conf[:tweetstream][:channel]).send text
    end

  end
end
