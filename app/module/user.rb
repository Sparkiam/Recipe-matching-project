class User < ActiveRecord::Base
  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients

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

  def recipes_i_can_make
    can_make = []
    almost_can = []
    Recipe.all.each do |recipe|
      missing = []
      recipe.get_ingredients_names.each do |ingr|
        # binding.pry
        if !self.get_ingredients_names.include?(ingr)
          missing << ingr
        end
      end
      if missing.length == 0
        can_make << recipe.name
      elsif missing.length <= 2
       # puts "You are only missing 1 ingredient: #{missing[0]}"
       almost_can << recipe.name
     end
    end
    puts "You can make:"
    print_recipes(can_make)
    puts "~~~~~~~~~~"
    puts "You need a few more ingredients"
    print_recipes(almost_can)
  end

  def print_recipes(arr)
    arr.each_with_index do |recipe, i|
      puts "#{i+1} - #{recipe}"
    end
    return ""
  end
end
