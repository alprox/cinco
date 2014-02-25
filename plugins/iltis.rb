class Iltis
 include Cinch::Plugin
  
  listen_to :message

  ILTANYYMI = File.open("#{File.dirname(__FILE__)}/iltis").read.split("%").map{|f| f.sub("\n", "").strip }
  def iltis
	iltis = ILTANYYMI[rand(56)]
  end

  def listen(m)
    switch_regex = /!iltis/
    match = switch_regex.match(m.message)
    if match
        m.reply iltis
    end
  end

end
