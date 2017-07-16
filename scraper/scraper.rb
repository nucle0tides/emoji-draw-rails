require 'open-uri'
require 'nokogiri'

class Scraper 
	def initialize 
		base_url = 'http://emojipedia.org'
		emoji_grid_url = 'http://emojipedia.org/messenger/1.0'
		base_page = Nokogiri::HTML(open(emoji_grid_url))
	end

	def emoji_scraper_runner
		links = emoji_links
		links.each do |link|
			page = Nokogiri::HTML(open(base_url + link))
			emoji = page.css('.vendor-set-emoji-image img')
			e_name = emoji_name(emoji)
			e_src = emoji_src(emoji)
			download_emoji(e_name, e_src)
		end
	end 
	private 

	def emoji_links
		links_list = []
		emoji_li = base_page.css('.emoji-grid li a')	
		emoji_li.each do |li|
			links_list.push(li.attr('href'))
		end
		links_list
	end 

	def emoji_name(emoji)
		emoji.attr('alt').to_s.chomp(' on Messenger 1.0')
	end 

	def emoji_src(emoji)
		emoji.attr('src').to_s
	end

	def download_emoji(name, src)
		puts "Saving #{name}"
		emoji_img = open(src).read
		File.write("emojis/#{name}.png", emoji_img)
	end 
end 

scraper = Scraper.new 
scraper.emoji_scraper_runner