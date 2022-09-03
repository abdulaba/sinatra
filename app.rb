require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require "pry-byebug"
require "better_errors"
require_relative "config/application"


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

get '/restaurants/:id/edit' do  #load edit form
    @restaurant = Restaurant.find_by(id: params[:id])
    erb :edit
end

patch '/restaurants/:id' do #update the article
  @restaurant = Restaurant.find_by(id: params[:id])
  @restaurant.update(name: params[:name])
  redirect to "/restaurants"
end

delete '/' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.delete
  redirect to "/restaurants"
end

