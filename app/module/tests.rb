require 'pry'
require 'rest-client'
require 'json'
require_relative '../../config/environment.rb'

result = []

3.times do |i|
  # binding.pry
  response = RestClient.get("http://www.recipepuppy.com/api/?q=chicken&p=#{i+1}")
  # sleep(1)
  data = JSON.parse(response.body)
  data["results"].each do |food_list|
    result << food_list
  end
end

def get_ingredients(arr)
  ingredients = []
  arr.each do |parameters|
    ingredients << parameters["ingredients"].split(", ")
  end
  ingredients.flatten.uniq.sort
end

my_arr = get_ingredients(result)

binding.pry
0
