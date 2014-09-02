# Modified from https://github.com/bounb/choadbot/blob/master/plugins/translate/translate.rb thank you!
# encoding: utf-8

class Translate
	include Cinch::Plugin

	match /hinis (.*)/iu

	def execute(m, message)

		begin
			url = open("https://api.datamarket.azure.com/Bing/MicrosoftTranslator/v1/Translate?Text=%27#{URI.escape(message)}%27&To=%27en%27", :http_basic_authentication=>[$AZUREU, $AZUREP])
			url = Nokogiri::XML(url)

			result = url.xpath("//d:Text").text

			m.reply "#{result}"
		rescue
			m.reply "haista vittu"
		end
	end
end
