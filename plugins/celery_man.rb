# encoding: utf-8
# Loads up Celery Man
# Ported from originan source by github:
# https://github.com/github/hubot-scripts/blob/master/src/scripts/celery-man.coffee


class CeleryMan
  include Cinch::Plugin

  listen_to :message

  # TODO: DRY THIS SHIT UP
  def listen(m)
    m.reply "http://mlkshk.com/r/4SBP.gif" if m.message.match /.*celery\s?man/i

    if m.message.match /.*4d3d3d3/i
      m.reply "4d3d3d3 ENGAGED"
      m.reply "http://i.imgur.com/w1qQO.gif"
    end

    m.reply "http://i.imgur.com/EH2CJ.png" if m.message.match /.*add sequence:? oyster/i
    m.reply "http://i.imgur.com/e71P6.png" if m.message.match /.*oyster smiling/

    if m.message.match /do we have any new sequences/i
      m.reply "I have a BETA sequence I have been working on. Would you like to see it? \n"
    end

    if m.message.match /.*beta sequence/i
      m.reply "http://i.imgur.com/JD6mz.jpg\n"
      m.reply "http://i.imgur.com/TvoxF.gif"
    end

    m.reply "http://i.imgur.com/5kVq4.gif" if m.message.match /.*hat wobble/i
    m.reply "http://i.imgur.com/X0sNq.gif" if m.message.match /.*flarhgunnstow/i
    m.reply "Not computing. Please repeat:" if m.message.match /.*nude tayne/
    m.reply "http://i.imgur.com/yzLcf.png" if m.message.match /NUDE TAYNE/

    m.reply "#{m.user.nick} oot homo" if m.message.match /!kurre/
    m.reply "http://i.imgur.com/9W0PA.gif" if m.message.match /.*2spooky/
    m.reply "http://i.imm.io/Tpza.gif" if m.message.match /discojytä/
    m.reply "http://rakka.us.to/tuuhea.gif" if m.message.match /!tuuhea/
    m.reply "http://i.imgur.com/xU6hA.gif" if m.message.match /.*tissit/
    m.reply "I feel offended by your recent action(s). Please read http://stop-irc-bullying.eu/stop" if m.message.match /paska botti/
    m.reply "mumble: es.rbt.asia:64420" if m.message.match /!mumble/
    m.reply "radio: http://rakka.us.to:8000/stream" if m.message.match /!radio/

  end
end
