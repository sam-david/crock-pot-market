
get '/' do
  @twitter_users = []
  erb :index
end

get '/crockpots' do
  # session[:current_category] = params[:category_name]
  # category = Category.where(name: params[:category_name]).first
  content_type :JSON
  products = Product.all
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
  # if category == nil
  #   twitter_users.to_json
  # else
  #   if request.xhr?
  #     twitter_users.to_json
  #   else
  #     erb :index
  #   end
  # end
end

get '/crockpots/:brand' do
  content_type :JSON
  products = Product.where(brand: params[:brand])
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
end

get '/crockpots/brand/other' do
  content_type :JSON
  Product.where.not(brand: ['Crock-Pot','Breville'])
  products = Product.where.not(brand: ['Crock-Pot','Hamilton Beach','Breville','Cuisinart'])
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
end

get '/crockpots/capacity/large' do
  content_type :JSON
  products = Product.where('capacity > 6.5')
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
end

get '/crockpots/capacity/medium' do
  content_type :JSON
  products = Product.where('capacity >= 5 AND capacity <= 6.5')
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
end

get '/crockpots/capacity/small' do
  content_type :JSON
  products = Product.where('capacity < 5')
  products.each do |product|
    product.bullets = JSON::parse(product.bullets)
  end
  products.to_json
end

get 'crockpots/sort/:type' do
  params[:type]
end



# post '/add_todo' do
#   if request.xhr?
#     new_todo = Todo.create(todo_content: params[:todo_content])
#     content_type :JSON
#     new_todo.to_json
#   else
#     new_todo = Todo.create(todo_content: params[:todo_content])
#   end
# end

# put '/todos/:id' do
#   if request.xhr?
#     todo = Todo.find(params[:id])
#     todo.update_attributes(params[:todo])
#     content_type :JSON
#     todo.to_json
#   end
# end


# delete '/todos/:id' do
#   if request.xhr?
#     todo = Todo.find(params[:id]).destroy
#     content_type :JSON
#     todo.to_json
#   end
# end
