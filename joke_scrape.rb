require 'rest-client'
require 'open-uri'
require 'nokogiri'
require 'awesome_print'
require 'colorize'

url = "www.laughfactor.com/jokes/joke-of-the-day/"

response = RestClient.get(url)
html = response.body
# html = open('jokepage.html')



document = Nokogiri::HTML(html)
ap document

joke = document.css('.joke-area').css('.line')[0].css('.joke3-pop-box').css('p').text().strip
# joke = document.css('.joke-area').css('.line')


# joke = document.css('.joke-area>.line:first .joke3-pop-box p').text()
puts 'here joke'
ap joke

# if horoscope.empty?
#   puts "no horoscope found for #{search_sign} #{search_period}.".white.on_red
# else
#   puts (search_period+' - '+search_sign).ljust(15).yellow.bold.on_light_blue
#   p horoscope.text
# end
