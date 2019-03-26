class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def get_ingredients_names
    self.ingredients.map do |ingredient|
      ingredient.name
    end
  end

  def self.get_average_ingredient_per_recipe
    (Recipe.all.inject(0.0) do |sum, recipe|
      sum + recipe.ingredients.length
    end / Recipe.all.length).round(2)
  end

end
