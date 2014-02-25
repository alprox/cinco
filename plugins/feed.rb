require "nokogiri"

class Feed
    include Cinch::Plugin

    timer INTERVAL, method: :updatefeed
    def updatefeed
      feed = Nokogiri::XML(open(FEED), nil, 'ISO-8859-1')
      sub = feed.css("item").first
      new = sub.css("title").inner_text.to_s
      if defined? @old
        printnew(sub) unless new == @old
      end
      @old = new
      end

      def printnew(title)
      Channel(CHANNEL).send "%s" % [
      title.css("description").inner_text,
      ]
    end
  end
