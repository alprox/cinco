require 'youtube_it'

class Youtube
  include Cinch::Plugin

	match /.*(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?(\S{10,}).*/ix, prefix:""
	def execute(m,id)
		client = YouTubeIt::Client.new
		video = client.video_by(id)
		m.reply Cinch::Formatting.format("%s: #{video.title} :: #{video.unique_id} :: Views: #{video.view_count}" % [Format(:bold, :red, 'Youtube')])
	end
end
