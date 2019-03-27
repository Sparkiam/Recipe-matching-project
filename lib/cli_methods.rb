def greeting
  puts "Welcome to your nightmare!\nWe are your hosts: Yev and Jack!"
  puts "~~~~~~\n~~~~~~\n~~~~~~"
  # sleep(1)
  puts "Please, tell us your name"
end

def loading(length, symbol)
  length.times do |a|
    print symbol
    sleep(0.05)
  end
end

def gathering_user_data(input)
  current_user = User.find_by("username = '#{input}'")
  if current_user
     puts "Oh, no, not you again..."
  else
    current_user = User.create(:username => input)
    puts "#{input.capitalize}?! What a dumb name!!"
  end
  # sleep(1)
  puts "Well, #{input.capitalize}, I guess we could help you out!"
  # sleep(1)
  puts "So, tell us something..."
  return current_user
end

def kitchen_query(user)
  puts "What food do you have in your kitchen?"
  puts "Hint: Once you are done checking your kitchen, press 'q'\nPress 'h' for more options"
  food = ""
  while food != "q"
    food = gets.chomp.downcase
    if food == "h"
    puts "So, you need help?!\nPress 'i' for an idea of what you have\nOr press 'k' to list what is already in your kitchen!\nPress 'm' to magically add food to your kitchen!\nAnd press 'x' to leave our program!"
    # binding.pry
    elsif food == "i"
      puts Ingredient.get_ingredients_names.sample(10)
    elsif food == "k"
      puts user.get_ingredients_names
    elsif food == "h"
      break
    elsif food == "x"
      return "Thank you! Maybe next time..."
    elsif food == "m"
      puts "Cheating is not beneath you I see...."
      sleep(1)
      puts "Very well, then. ZOBOOMAFU!!"
      user.magic
    elsif Ingredient.get_ingredients_names.include?(food)
      user.add_ingredient(food)
      array = ["That's gross", "Wow, me too!", "I just ran out of that!", "My cat likes that too", "We threw one of those away this morning, I hope you didn't get ours...", "#{food.capitalize}! Sounds tasty!!!"]
      puts array.sample
    elsif food != "q"
      puts "Whoa, that's not an ingredient we have on record! Please try again!"
    end
  end
end

# def decision(current_user)
#   choice = ""
#   while choice != "3"
#     choice = gets.chomp
#     if choice == "1"
#       puts "Let's get started!"
#       cooking(current_user)
#       #should choosing this option break you out of this method?
#     elsif choice == "2"
#       puts "Oh, there's more!"
#       kitchen_query(current_user)
#       puts "Now are you ready to cook?"
#       puts "1) 'Yes!'\n2) 'Hold on, hold on, I've got even MORE food!''\n3)'I'm out, you are very rude!'"
#     elsif choice == "3"
#       break
#     else
#       puts "What!? I didn't catch that"
#     end
#   end
#   puts "Oh okay, TTFN!"
# end

def cooking(current_user)
  puts "So, you have your ingredients, yea?\n\nLet's find out what you can make..."
  sleep(1)
  puts "Sorting.... Processing...\n"
  sleep(1)
  puts "Ding, all sorted!"
  current_user.get_recipes_i_can_make
  current_user.list_complete_recipes
  current_user.list_incomplete_recipes
  #it goes back into the decision method. So we need to connect to a new method or break out of that one
end

def functions(current_user)
  input = ""
  while input != "5"
    puts "\nHow can I help you?"
    puts "
    1) Check my Kitchen for Ingredients\n
    2) See what Recipes I can make\n
    3) Cook a Recipe\n
    4) Remove Myself from this confounded Program\n
    5) Exit the program"
    input = gets.chomp
    if input == "1"
      kitchen_query(current_user)
    elsif input == "2"
      cooking(current_user)
    elsif input == "3"
      #method
    elsif input == "4"
      puts "Oh, are you sure!?\nY/N"
      confirm = gets.chomp
      if confirm == "Y"
        puts "Oh, alright...."
        sleep(1)
        puts "I told myself I wouldn't cry.."
        sleep(1)
        puts "Very well then"
        User.remove_user("#{current_user.username}")
        return "Goodbye"
      else
        puts "Oh, you must've hit this by mistake! Sorry about that!"
      end
    elsif input == "5" || input == "quit"
      puts "Loud and clear! Until next time...."
      break
    else
      puts "Nice try, but not nice enough"
      sleep(1)
    end
  end
end
