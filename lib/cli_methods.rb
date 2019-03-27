def kitchen_query(user)
  puts "What food do you have in your kitchen?"
  puts "Hint: Once you are done checking your kitchen, press 'q'\nPress 'i' for a ideas"
  food = ""
  while food != "q"
    food = gets.chomp.downcase
    if food == "i"
      puts Ingredient.get_ingredients_names.sample(10)
    elsif Ingredient.get_ingredients_names.include?(food)
      user.add_ingredient(food)
      array = ["That's gross", "Wow, me too!", "I just ran out of that!", "My cat likes that too", "We threw one of those away this morning, I hope you didn't get ours...", "#{food.capitalize}! Sounds tasty!!!"]
      puts array.sample
    elsif food != "q"
      puts "Whoa, that's not an ingredient we have on record! Please try again!"
    end
  end
end

def decision(current_user)
  choice = ""
  while choice != "3"
    choice = gets.chomp
    if choice == "1"
      puts "Let's get started!"
      cooking(current_user)
      #should choosing this option break you out of this method?
    elsif choice == "2"
      puts "Oh, there's more!"
      kitchen_query(current_user)
      puts "Now are you ready to cook?"
      puts "1) 'Yes!'\n2) 'Hold on, hold on, I've got even MORE food!''\n3)'I'm out, you are very rude!'"
    elsif choice == "3"
      break
    else
      puts "What!? I didn't catch that"
    end
  end
  puts "Oh okay, TTFN!"
end

def cooking(current_user)
  puts "So, you have your ingredients, yea?\n\nLet's find out what you can make..."
  # sleep(1)
  puts "Sorting.... Processing...\n"
  # sleep(1)
  puts "Ding, all sorted!"
  current_user.get_recipes_i_complete_recipes
  binding.pry
  #it goes back into the decision method. So we need to connect to a new method or break out of that one
end
