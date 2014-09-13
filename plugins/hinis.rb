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
	end

	def listen(m)
	switch_regex = /cinco\s(?<switch>pls|mee pois)/
	switchmatch = switch_regex.match(m.message)
	if switchmatch
	  if switchmatch[:switch] == "pls"
	    @turning = true
	    m.reply "wowwhoa"
	  elsif switchmatch[:switch] == "mee pois"
	    @turning = false
	    m.reply "haista vittu"
	  end
	elsif m.user.host == "nallepuku.info" and m.user.realname == "┐(´ー`)┌" and @turning == true

	  begin
		url = open("https://api.datamarket.azure.com/Bing/MicrosoftTranslator/v1/Translate?Text=%27#{URI.escape(m.message)}%27&To=%27en%27", :http_basic_authentication=>[$AZUREU, $AZUREP])
		url = Nokogiri::XML(url)

		result = url.xpath("//d:Text").text

		m.reply "#{result}"
	  rescue
		m.reply "#{m.user.nick} haista vittu"
	  end
	end
	end
end
