require 'yt'

class Youtube
  include Cinch::Plugin

    def initialize(*args)
      super
      Yt.configuration.api_key = Conf[:google][:api_key]
    end

    match /.*(?:youtu.be\/|\/v\/|\/u\/\w\/|embed\/|watch\?v=)([a-zA-Z0-9_-]+)/ix, prefix:""

    def execute(m, video_id)
      video = Yt::Video.new id: video_id
      views = video.view_count.to_s.reverse.scan(/\d{3}|.+/).join(",").reverse
      duration = Time.at(video.duration).utc.strftime("%H:%M:%S")
      m.reply Cinch::Formatting.format("%s: #{video.title} :: #{video.id} :: #{video.channel_title} :: #{views} :: #{duration}" %
              [Format(:bold, :red, 'Youtube')])
      end
end
