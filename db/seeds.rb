# category_array = ["tech","music","sports","photo","entertainment","news","fashion","food","television","movies","family","art","business","finance","health","books","science","faith","government","social_good","travel","gaming","nba","nfl","mlb","nascar","nhl","pga"]
products_array = []
product_asin_array = [
	"B004P2NG0K",
	"B001AO2PXK",
	"B003UCG8II",
	"B005OYE7HE",
	"B007K9OI9I",
	"B003HF6PUO",
	"B0002CA3C6",
	"B001KVZTFO",
	"B005M8IP0W",
	"B008YEXC22",
	"B00DG08KJO",
	"B006B70DOE",
	"B002OT03FC",
	"B00499D62M",
	"B00E390Y28",
	"B009T7H0QM",
	"B00DHLACZ2",
	"B009XZVKDE",
	"B008J8MKP8",
	"B001E5CWVU",
	"B00EZI26C8",
	"B00577LSQG",
	"B001AH5H0A",
	"B00418481E",
	"B008S6ZJOA"]

product_asin_array.each_with_index do |product, index|
	p "Item: #{index + 1}"
	if Product.where(asin: product) == []
		products_array << ProductInfo.fetch(product)
	else
		p "we got that work"
	end
end

p "**********************  products array **********************"
p products_array.length
p "**********************  products array **********************"

products_array.each do |product_to_add|
	if Product.where(asin: product_to_add["asin"]) == []
		p "not found, creating..."
		Product.create(name: product_to_add["name"], price: product_to_add["price"], rating: product_to_add["rating"], model_number: product_to_add["model_number"], asin: product_to_add["asin"], weight: product_to_add["weight"], dimensions: product_to_add["dimensions"], bullets: product_to_add["bullets"], description: product_to_add["description"], image_source: product_to_add["image_source"])
	else
		p "we already got one of those"
	end
	# Product.find_or_create_by(name: product_to_add["name"]) do |product_col|
	# 	product_col.price = product_to_add["price"], 
	# 	product_col.rating = product_to_add["amazon_rating"], 
	# 	product_col.model_number = product_to_add["model_number"],
	# 	product_col.asin = product_to_add["asin"], 
	# 	product_col.weight = product_to_add["weight"], 
	# 	product_col.dimensions = product_to_add["dimensions"], 
	# 	product_col.description = product_to_add["description"]
	# end
end
# category_array.each do |category|
#   Category.create(name: category)
# end