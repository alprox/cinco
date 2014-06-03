class Meemu
  include Cinch::Plugin

  listen_to :message

  ILTIS = File.open("#{File.dirname(__FILE__)}/iltis").read.split("%").map{|f| f.sub("\n", "").strip }
  KURRE = File.open("#{File.dirname(__FILE__)}/kurre").read.split("%").map{|f| f.sub("\n", "").strip } 

  def iltis
  	iltis = ILTIS[rand(100)]
  end

  def kurre
  	kurre = KURRE[rand(100)]
  end

  def listen(m)

	switch_regex = /!kurre/
	match = switch_regex.match(m.message)
	if match
		m.reply kurre
		m.reply "#{m.user.nick} oot homo"
	end
	switch_regex = /!iltis/
	match = switch_regex.match(m.message)
	if match
		m.reply iltis
	end

	m.reply "http://i.imgur.com/9W0PA.gif" if m.message.match /.*2spooky/
	m.reply "http://i.imm.io/Tpza.gif" if m.message.match /discojytä/
	m.reply "http://rakka.us.to/tuuhea.gif" if m.message.match /!tuuhea/
	m.reply "http://i.imgur.com/xU6hA.gif" if m.message.match /.*tissit/
	m.reply "I feel offended by your recent action(s). Please read http://stop-irc-bullying.eu/stop" if m.message.match /paska botti/
	m.reply "mumble: es.rbt.asia:64420" if m.message.match /!mumble/
	m.reply "radio: http://rakka.us.to:8001/stream" if m.message.match /!radio/
  end
end
