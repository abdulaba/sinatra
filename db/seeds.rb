require "faker"

10.times do
  Restaurant.create!(
    name: Faker::Coffee.blend_name,
    city: Faker::TvShows::GameOfThrones.city
  )
end
