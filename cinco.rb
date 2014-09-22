require 'cinch'
require "cinch/plugins/identify"
require 'cinch/plugins/title'
require 'cinch/cooldown'
require 'nokogiri'
require 'time'
require 'yaml'

require_relative 'plugins/youtube'
require_relative 'plugins/celery_man'
require_relative 'plugins/thom'
require_relative 'plugins/twiddle'
require_relative 'plugins/updown'
require_relative 'plugins/title'
require_relative 'plugins/eka'
require_relative 'plugins/meemu'
require_relative 'plugins/translate'
require_relative 'plugins/hinis'

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
		Hinis
		]

	c.plugins.options[Cinch::Plugins::Identify] = Conf[:irc_auth]
	c.plugins.options[Title] = Conf[:title][:ignore]
#	c.shared[:cooldown] = Conf[:cooldown]
	c.shared[:cooldown] = { :config => { '#rakkaus' => { :global => 10, :user => 20 } } }
end
end

bot.start
