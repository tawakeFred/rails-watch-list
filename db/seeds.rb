require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "- Removing all movies!"
Movie.destroy_all
# List.destroy_all

# the Le Wagon copy of the API
# url = 'http://tmdb.lewagon.com/movie/top_rated'
  url = 'https://api.themoviedb.org/3/movie/upcoming?region=jp&api_key=816daa8e56b127200f2275897b7ebae4'
response = JSON.parse(URI.open(url).read)

response['results'].each do |movie_hash|
  movie_title = movie_hash['title']
  if movie_hash['overview'].empty?
    movie_overview = "No overview provided... :("
  else
    movie_overview = movie_hash['overview']
  end

  movie_poster = "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path']
  movie_rating = movie_hash['vote_average']

  # create an instance with the hash
  Movie.create!(title: movie_title, overview: movie_overview, poster_url: movie_poster, rating: movie_rating)
end
puts " - Added #{Movie.count} movies"
