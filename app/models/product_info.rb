require 'csv'
require 'nokogiri'
require 'open-uri'
require 'json'

CSV_PATH = 'crock-pots.csv'

module ProductInfo
	def initialize(asin)
		@asin = asin
		@name = ""
		@price = 0
		@bullets = []
		@description = ""
		@rating = ""
		@weight = ""
		@model_number = ""
		@dimensions = ""
		get_product_info(@asin)
	end


	def self.fetch(asin)
		begin
			product_page = Nokogiri::HTML(open("http://www.amazon.com/gp/product/#{asin}"))
		rescue OpenURI::HTTPError => error
			puts "#{asin}: no connection", asin
			return ""
		else
			puts "#{asin}: successful connection"
			name = ""
			price = 0
			bullets = []
			description = ""
			rating = ""
			weight = ""
			model_number = ""
			dimensions = ""
			description_array = product_page.css(".content").css("ul").text.split("\n").reject! { |c| c.empty? }
			description_array.each do |line|
				if line.include? "Shipping Weight:"
					weight = /\d+.\d+|\d+/.match(line).to_s
				elsif line.include? "model number"
					model_number = /\d+/.match(line).to_s
				elsif line.include? "inches"
					dimensions = line.scan(/\d+.\d+|\d+/)[0..2].to_s
				end
			end
			name = product_page.css("#productTitle").text
			price = /\d+.\d+/.match(product_page.css("#priceblock_ourprice").text).to_s.to_f
			bullets = product_page.css('#feature-bullets').text.gsub("\t","").split("\n").reject! { |c| c.empty? }.to_json
			description = product_page.css('.productDescriptionWrapper').text.gsub("\n","").gsub(/ {2,}/, " ").gsub("✔", "").rstrip.lstrip
			rating = product_page.css(".swSprite").text[0..2].to_s.to_f
			image = product_page.css(".a-dynamic-image").attr('src').text
			File.open("public/images/crockpots/#{asin}.jpg", "wb") do |file|
				file << open(image).read
			end
			product_hash = {"name" => name, "price" => price, "bullets" => bullets, "rating" => rating, "model_number" => model_number, "asin" => asin, "weight" => weight, "dimensions" => dimensions, "description" => description, "image_source" => image }
			save_to_csv(product_hash)
			sleep 0.1
			save_to_csv(product_hash)
			return product_hash
		end
	end

	def self.save_to_csv(product_hash)
		CSV.open(CSV_PATH,'ab') do |line|
			line << [product_hash["name"],product_hash["price"],product_hash["bullets"],product_hash["rating"],product_hash["model_number"],product_hash["asin"],product_hash["weight"],product_hash["dimensions"],product_hash["description"]]
		end
	end
end