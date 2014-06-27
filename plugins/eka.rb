CHANNEL = "#rakkaus"

require 'time'
require 'chronic_duration'

class Eka
   include Cinch::Plugin

	timer 1, :method => :tick

	def initialize(*args)
	 super
	 @last_time = nil
	end

	def tick

		local = Time.now

		if @last_time.nil?
		  @last_time = local.hour

		elsif @last_time != local.hour
		  @last_time = local.hour
		end

		if local.hour == 0 and local.min == 0 and local.sec == 0
		  Channel(CHANNEL).send "eka"
		end

		if local.hour == 4 and local.min == 20 and local.sec == 0
		  Channel(CHANNEL).send "420 dudebroheim"
		end

		if local.hour == 17 and local.min == 0 and local.sec == 0
		  if local.friday?
		    Channel(CHANNEL).send "*koff*"
		  end
		end

		if local.hour == 7 and local.min == 0 and local.sec == 0
		  if local.monday?
		    Channel(CHANNEL).send "bää bää vitun lampaat"
		  end
		end
	end
end
