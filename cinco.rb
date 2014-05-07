#FEED = "https://api.twitter.com/1/statuses/user_timeline.rss?screen_name=Bakayarosan" #pupu
#INTERVAL = "60"
#CHANNEL = "#rakkaus"

require 'cinch'
require "cinch/plugins/identify"
require 'cinch/plugins/title'
require 'nokogiri'
require 'time'

#require_relative 'plugins/feed'
#require_relative 'plugins/iltis'
require_relative 'plugins/youtube'
require_relative 'plugins/celery_man'
require_relative 'plugins/thom'
require_relative 'plugins/kurre'
require_relative 'plugins/twiddle'
require_relative 'plugins/updown'

bot = Cinch::Bot.new do
configure do |c|
	c.server = 'localhost'
	c.channels = ["#avaruuskulttuuri"]
	c.nick = 'cinco'
 	c.plugins.plugins = [
		Cinch::Plugins::Title,
		Cinch::Plugins::Identify,
#		Feed,
#		Iltis,
		Youtube,
		CeleryMan,
		Thom,
		Kurre,
		Twiddle,
		UpDown
		]

    c.plugins.options[Cinch::Plugins::Identify] = { :username => "cinco", :password => "haha", :type => :nickserv }
    c.plugins.options[Cinch::Plugins::Title] = { "ignore" => [ "youtube.com", "donmai.us", "gelbooru.com", "konachan.com", "puu.sh", "exhentai.org", "youtu.be" ] }

end
end

bot.start
