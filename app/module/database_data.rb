require 'pry'
require 'rest-client'
require 'json'

ALL_RECIPES = []

def pull_recipes(ingredient)
  10.times do |i|
    # binding.pry
    response = RestClient.get("http://www.recipepuppy.com/api/?q=#{ingredient}&p=#{i+1}")
    # sleep(1)
    data = JSON.parse(response.body)
    data["results"].each do |food_list|
      ALL_RECIPES << food_list
    end
  end
end


def add_cost
  ids = Ingredient.all.ids
  ids.each do |id|
    Ingredient.update(id, cost: get_random)
  end
end

def add_tastiness
  ids = Ingredient.all.ids
  ids.each do |id|
    Ingredient.update(id, tastiness: get_random)
  end
end

def add_prep_time
  ids = Recipe.all.ids
  ids.each do |id|
    Recipe.update(id, prep_time: get_random)
  end
end

def get_ingredients(arr)
  ingredients = []
  arr.each do |parameters|
    ingredients << parameters["ingredients"].split(", ")
  end
  ingredients.flatten.uniq.sort
end

print

def get_random
  rand(1..10)
end

def add_ingredients
  all_ingredients = get_ingredients(ALL_RECIPES)
  all_ingredients.each do |ingr|
    Ingredient.find_or_create_by(:name => ingr)
  end
end

def add_recipe(recipe)
  name = recipe["title"].gsub("Recipe","").rstrip
  Recipe.find_or_create_by(:name => name, :link => recipe["href"])
end

def map_recipe_with_ingredient(recipe_list)
  recipe_list.each do |recipe|
    new = add_recipe(recipe)
    recipe["ingredients"].split(", ").each do |ing|
      # if !ing.include?(" ")
        ingredient = Ingredient.where("name = '#{ing}'")[0]
        RecipeIngredient.find_or_create_by(:recipe_id => new.id, :ingredient_id => ingredient.id)
      # end
    end
  end
end
