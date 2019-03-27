class User < ActiveRecord::Base
  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients
  attr_accessor :complete_recipes, :incomplete_recipes

  def initialize(username:)
    super
    @username = username
    @complete_recipes = []
    @incomplete_recipes = []
  end

  def self.remove_user(username)
    user = User.where("username = '#{username}'")[0]
    # binding.pry
    User.delete(user.id)
  end

  def add_ingredient(ingr)
    # binding.pry
    user = User.where("username = '#{self.username}'")[0]
    ingredient = Ingredient.where("name = '#{ingr}'")[0]
    UserIngredient.find_or_create_by(:user_id => user.id, :ingredient_id => ingredient.id)
  end

  def get_ingredients_names
    self.ingredients.map do |ingredient|
      ingredient.name
    end
  end

  def get_recipes_i_complete_recipes
    @complete_recipes = []
    @incomplete_recipes = []
    h = {}
    Recipe.all.each do |recipe|
      missing = []
      recipe.get_ingredients_names.each do |ingr|
        if !self.get_ingredients_names.include?(ingr)
          missing << ingr
        end
      end
      h = {}
      if missing.length == 0
        h["recipe"] = recipe
        h["missing"] = missing
        self.complete_recipes << h
      elsif missing.length <= 2
        h["recipe"] = recipe
        h["missing"] = missing
        self.incomplete_recipes << h
     end
    end
    nil
  end

  def print_recipes(arr)
    arr.each_with_index do |recipe, i|
      puts "#{i+1} - #{recipe}"
    end
    return ""
  end

  def list_complete_recipes
    puts "Lets search what you can cook"
    puts "*" * 30
    if @complete_recipes.length != 0
      puts "With all of your ingredients, here is what you can make:"
      self.complete_recipes.each_with_index do |recipe, i|
        puts "#{i+1} - #{recipe["recipe"].name}"
      end
    else
      puts "With your current ingredients there are no recipes you can make!"
    end
  end

  def list_incomplete_recipes
    puts "Lets see if you are missing couple of ingredients to cook amazing meals"
    puts "*" * 30
    if @incomplete_recipes.length != 0
      puts "Huaaaa, good news, you only need a few more ingredients to make these recipes"
      self.incomplete_recipes.each_with_index do |recipe, i|
        puts "#{i+1} - #{recipe["recipe"].name}"
        puts "    Here is what you missing:"
        puts "    #{recipe["missing"].join(", ")}"
      end
    else
      puts "Nope, nothing even close"
    end
    return "*" * 30
  end
end
