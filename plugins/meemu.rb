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
	end
	switch_regex = /!iltis/
	match = switch_regex.match(m.message)
	if match
		m.reply iltis
	end
  end
end
