class Thom
 include Cinch::Plugin
  
  listen_to :message

  TOMPPA = File.open("#{File.dirname(__FILE__)}/thom").read.split("%").map{|f| f.sub("\n", "").strip }
  def thom
	thom = TOMPPA[rand(100)]
  end

  def listen(m)
    switch_regex = /!thom/
    match = switch_regex.match(m.message)
    if match
        m.reply thom
    end
  end

end
