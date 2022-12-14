require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require "pry-byebug"
require "better_errors"
require_relative "config/application"


configure :development do
  use Rack::MethodOverride
end




# after do
#   ActiveRecord::Base.connection.close
# end




get "/" do
  erb :home
end

get "/restaurants" do
  @restaurants = Restaurant.all
  erb :index
end

get "/restaurants/new" do
  @restaurant = Restaurant.new
  erb :new
end

post "/restaurants" do
  name = params[:name]
  city = params[:city]
  image_url = params[:image_url]
  address = params[:address]
  phone_number = params[:phone_number]
  type_food = params[type_food]
  Restaurant.create(name: name, city: city, image_url: image_url, phone_number: phone_number, address: address, type_food: type_food)
  redirect to "/restaurants"
end

get "/restaurants/:id" do
  id = params[:id]
  @restaurant = Restaurant.find(id)
  erb :show
end

get "/restaurants/:id/edit" do
  @restaurant = Restaurant.find(params[:id])

  erb :edit
end

patch "/restaurants/:id" do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.update(name: params[:name], address: params[:address], city: params[:city], phone_number: params[:phone_number], type_food: params[:type_food], image_url: params[:image_url])
  redirect to "/restaurants/#{@restaurant.id}"
end

delete "/restaurants/:id" do 
  Restaurant.find(params[:id]).destroy!
  redirect to "/restaurants"
end



