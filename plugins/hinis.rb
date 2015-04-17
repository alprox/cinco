# Modified from https://github.com/bounb/choadbot/blob/master/plugins/translate/translate.rb thank you!
# encoding: utf-8
require 'uri'
require 'open-uri/cached'
require 'nokogiri'

class Hinis
	include Cinch::Plugin

	listen_to :message
	
	def initialize(*args)
	  super
	  @turning = true
	  @confhost = "nallepuku.info"
	  @confuser = "hinanai"
	end

	def listen(m)
	switch_regex = /cinco\s(?<switch>pls|mee pois|)/
	conf_regex = /käännä\s(?<host>\S+)\s(?<user>\S+)/
	switchmatch = switch_regex.match(m.message)
	confmatch = conf_regex.match(m.message)

	if confmatch
	  @confhost = confmatch[:host]
	  @confuser = confmatch[:user]
	  m.reply "käännetään " + @confuser + "@" + @confhost
	end

	if switchmatch
	  if switchmatch[:switch] == "pls"
	    @turning = true
	    m.reply "wowwhoa"
	  elsif switchmatch[:switch] == "mee pois"
	    @turning = false
	    m.reply "haista vittu"
	  end

	elsif m.user.host == @confhost and m.user.user == @confuser and @turning == true

	  begin

	  	# lets remove irc color control chars
	  	smessage = m.message.gsub(/[[:cntrl:]]((\d{1,2},\d{1,2})|(\d{1,2}))|[[:cntrl:]]/, '')
		url = open("https://api.datamarket.azure.com/Bing/MicrosoftTranslator/v1/Translate?Text=%27#{URI.escape(smessage)}%27&To=%27en%27", :http_basic_authentication=>[Conf[:azure][:user], Conf[:azure][:pass]])
		url = Nokogiri::XML(url)

		result = url.xpath("//d:Text").text

		m.reply "#{result}"
	  rescue
		m.reply "#{m.user.nick} haista vittu"
	  end
	end
	end
end
