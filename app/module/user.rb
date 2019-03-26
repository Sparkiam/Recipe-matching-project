class User < ActiveRecord::Base
  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients
  attr_accessor = :can_make, :almost_can

  def initialize()
    @can_make = []
    @almost_can = []
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

  def get_recipes_i_can_make
    @can_make = []
    @almost_can = []
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
        h["recipe "] = recipe
        h["missing"] = missing
        @can_make << h
      elsif missing.length <= 2
        h["recipe "] = recipe
        h["missing"] = missing
        @almost_can << h
     end
    end
    binding.pry
    puts "You can make:"
    # print_recipes(@can_make)
    # puts "~~~~~~~~~~"
    # puts "You need a few more ingredients"
    # print_recipes(@almost_can)
  end

  def print_hash
    @can_make.map do |recipe|
      recipe.keys
    end

  end

  def print_recipes(arr)
    arr.each_with_index do |recipe, i|
      puts "#{i+1} - #{recipe}"
    end
    return ""
  end
end
