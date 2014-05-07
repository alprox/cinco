# Original author: Richard Banks <namaste@rawrnet.net>
# Modified by alprox 2014-05-07

require 'cinch'
require 'ostruct'
require 'open-uri/cached'
require 'json'
require 'cgi'

class UpDown
  include Cinch::Plugin

  set :plugin_name, 'updown'
  set :help, "!(up|down) <domain> - check if a domain is up or down for everyone"

  match /(?:up|down) (.+)/

  def execute(m, query)
	return m.reply "we trippy mane" if check(query).nil?
	updown_result(m, check(query))
  end

  def check(terms)
	url = JSON.parse(open("http://isitup.org/#{terms}.json").read)
	OpenStruct.new(
	domain: url['domain'],
	status: url['status_code'],
	time:	url['response_time']
	)
  rescue
	nil
  end

  def updown_result(m, url)
	if url.status == 3
		m.reply "Not a valid domain!"
	end

	if url.status == 2
		m.reply "#{url.domain} is down!"
	end

	if url.status == 1
		m.reply "#{url.domain} is up! Response time: #{url.time}"
	end
  end

end
