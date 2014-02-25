class Kurre
 include Cinch::Plugin
  
  listen_to :message

  KURRET = File.open("#{File.dirname(__FILE__)}/kurre").read.split("%").map{|f| f.sub("\n", "").strip }
  def orava
	kurre = KURRET[rand(10)]
  end

  def listen(m)
    switch_regex = /!kurre/
    match = switch_regex.match(m.message)
    if match
        m.reply "#{m.user.nick} oot homo :D tapa ittes :D"
    end
  end

end
