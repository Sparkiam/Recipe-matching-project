require 'pry'
require 'rest-client'
require 'json'

RESULT = []

3.times do |i|
  # binding.pry
  response = RestClient.get("http://www.recipepuppy.com/api/?q=chicken&p=#{i+1}")
  # sleep(1)
  data = JSON.parse(response.body)
  data["results"].each do |food_list|
    RESULT << food_list
  end
end

3.times do |i|
  # binding.pry
  response = RestClient.get("http://www.recipepuppy.com/api/?q=egg&p=#{i+1}")
  # sleep(1)
  data = JSON.parse(response.body)
  data["results"].each do |food_list|
    RESULT << food_list
  end
end

def get_ingredients(arr)
  ingredients = []
  arr.each do |parameters|
    ingredients << parameters["ingredients"].split(", ")
  end
  ingredients.flatten.uniq.sort
end



# my_arr = get_ingredients(RESULT)

def get_random
  rand(1..10)
end

def add_ingredients(ingredients)
  ingredients.each do |ingr|
    Ingredient.find_or_create_by(:name => ingr)
  end
end

def map_recipe(array)
  array.each do |recipe_list|
    new = Recipe.find_or_create_by(:name => recipe_list["title"], :link => recipe_list["href"])
    # binding.pry
    recipe_list["ingredients"].split(", ").each do |ing|
      ingredient = Ingredient.where("name = '#{ing}'")[0]
      # binding.pry
      RecipeIngredient.find_or_create_by(:recipe_id => new.id, :ingredient_id => ingredient.id)
    end
  end
end
