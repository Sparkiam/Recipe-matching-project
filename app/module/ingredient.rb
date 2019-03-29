class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :user_ingredients
  has_many :user, through: :user_ingredients

  def self.get_ingredients_names
    Ingredient.all.map do |ingr|
      ingr.name
    end
  end

  def self.find_capitalized
    ingredients = Ingredient.get_ingredients_names
    ingredients.select do |ingr|
      first_letter = ingr[0]
      first_letter == first_letter.upcase
    end
  end

  def self.remove_ingredient(name)
    ingredient = Ingredient.where("name = '#{name}'")[0]
    Ingredient.delete(ingredient.id)
  end

end
