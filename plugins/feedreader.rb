require 'cinch'
require 'feedzirra'

class Feedreader
  include Cinch::Plugin

  timer 60, method: :updatefeed
  def updatefeed
    feed = Feedzirra::Feed.fetch_and_parse("http://twitter.com/statuses/user_timeline/554626539.rss")
entry = feed.entries.first
entry.title
url = entry.url

if defined? @old
  printentry(title) unless entry == @old
end

sis = entry.title.encode(Encoding::UTF_8).sanitize
    msg = [sis, " | ", url].join(" ")
    Channel("#iltabot").send msg
  end
end
