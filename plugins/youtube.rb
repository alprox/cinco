require 'youtube_it'

class Youtube
  include Cinch::Plugin

	match /.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/ix, prefix:""
	def execute(m,id)
		client = YouTubeIt::Client.new
		video = client.video_by(id)
		views = video.view_count.to_s.reverse.scan(/\d{3}|.+/).join(",").reverse # fancy
		m.reply Cinch::Formatting.format("%s: #{video.title} :: #{video.unique_id} :: #{video.author.name} :: #{views}" % [Format(:bold, :red, 'Youtube')])
	end
end
