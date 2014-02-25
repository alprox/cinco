class Twiddle
  include Cinch::Plugin
  
  listen_to :message
  
  def listen(m)
    switch_regex = /KNOB TWIDDLER/
    match = switch_regex.match(m.message)
    if match
        m.reply cock + cunt
    end
  end
  
  def cock
    Cinch::Formatting.format(:bold,:pink, "https://www.youtube.com/watch?v=-M8sIzLNVT0")
  end
  
  def cunt
    Cinch::Formatting.format(:bold,:red, " COME ON YO CUNT !!!!")
  end
end
