class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def get_ingredients_names
    self.ingredients.map do |ingredient|
      ingredient.name
    end
  end

  def self.remove_recipe(name)
    if name.is_a?(String)
      recipe = Recipe.where("name = '#{name}'")
    else
      puts "Wrong argument"
    end
  end

  def self.get_recipe_names
    Recipe.all.map do |recipe|
      recipe.name
    end
  end

  def self.get_uniq_recipe_names
    get_recipe_names.uniq
  end

  def self.get_overlaping
    self.get_recipe_names.map do |recipe|
      self.get_uniq_recipe_names.each do |u_recipe|
        
      end
    end
  end

  def self.get_average_ingredient_per_recipe
    (Recipe.all.inject(0.0) do |sum, recipe|
      sum + recipe.ingredients.length
    end / Recipe.all.length).round(2)
  end

end
