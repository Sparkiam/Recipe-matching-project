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
    else
      puts "Whoa, that's not an ingredient we have on record! Please try again!"
    end
  end
end

# change it to while...or until loop?
# def decision(choice, current_user)
#   if choice == "1"
#     #new method
#   elsif choice == "2"
#     puts "Oh, there's more!"
#     kitchen_query(current_user)
#   elsif choice == "3"
#     puts "Oh okay, TTFN!"
#     break
#   else
#     puts "What!? I didn't catch that"
# end
