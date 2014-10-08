#!/usr/bin/env ruby
# encoding: utf-8

plugins = File.join(File.expand_path('..', __FILE__), '/plugins')
$:.unshift plugins unless $:.include?(plugins)
require 'bundler'
Bundler.require

require 'yaml'

%w( eka meemu thom translate tweet_stream youtube celery_man hinis title twiddle updown ).each {|file|
  require file
}

Conf = YAML.load_file("config.yml")

bot = Cinch::Bot.new do
configure do |c|
	c.server = Conf[:irc][:server]
	c.port = Conf[:irc][:port]
	c.nick = Conf[:irc][:nick]
	c.user = Conf[:irc][:user]
	c.realname = Conf[:irc][:realname]
	c.channels = Conf[:irc][:channels]
	c.plugins.plugins = [
		Title,
		Cinch::Plugins::Identify,
		Youtube,
		CeleryMan,
		Thom,
		Meemu,
		Twiddle,
		UpDown,
		Eka,
		Translate,
		Hinis,
		Cinch::Plugins::TweetStream
		]

	c.plugins.options[Cinch::Plugins::Identify] = Conf[:irc][:irc_auth]
	c.plugins.options[Title] = Conf[:title]
	c.shared[:cooldown] = Conf[:cooldown]
end
end

Thread.new { ::TweetStream.new(bot).run }

bot.start
