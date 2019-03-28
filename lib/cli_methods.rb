def greeting
  puts "Welcome to Kitchen Helper!\nWe are your hosts: Yev and Jack!"
  # puts "~~~~~~\n~~~~~~\n~~~~~~"
  loading(10, "~")
  loading(10, "~")
  loading(10, "~")
  puts "Please, tell us your name, kind one"
end

def loading(length, sym)
  length.times do |a|
    print sym
    sleep(0.1)
  end
  puts ""
end

def print_array(array)
  array.each_with_index do |item, i|
    puts "#{i+1}. #{item.capitalize}"
  end
end

def gathering_user_data(input)
  loading(20, ".")
  system "clear" or system "cls"
  current_user = User.find_by("username = '#{input}'")
  if current_user
     puts "Oh, no, not you again..."
  else
    current_user = User.create(:username => input)
    puts "#{input.capitalize}?! Can it really be you!?!!\n\nWelcome #{input.capitalize}"
  end
  sleep(1)
  puts "Well, #{input.capitalize}, we are here to give you a hand in your kitchen!"
  sleep(1)
  # puts "So, tell us something..."
  return current_user
end

def kitchen_query(user)
  puts "\nWhat food do you have in your kitchen?"
  puts "Hint: Once you are done checking your kitchen, press 'q'\nPress 'h' for more options"
  food = ""
  i = 0
  while food != "q"
    if i > 0
      puts "\nWhat else do you have in your kitchen?"
      if i > 3
        puts "Press 'q' to stop checking your kitchen"
      end
    end
    i += 1
    food = gets.chomp.downcase
    if food == "h"
    puts "\nSo, you need help?!\n'i' - For what you might have in your kitchen!\n'k' - To list what is already in your kitchen!\n'm' - To magically add food to your kitchen!\n'd' - To remove an item from your kitchen!\n'q' - To quit checking your kitchen!"
    # puts "\nSo, you need help?!\nPress 'i' for an idea of what you have\nOr press 'k' to list what is already in your kitchen!\nPress 'm' to magically add food to your kitchen!\nPress 'd' to remove an item from your kitchen\nAnd press 'q' to stop checking your kitchen!"
    # binding.pry
    elsif food == "i"
      puts "\nNeed help? Do you have any of these?"
      print_array(Ingredient.get_ingredients_names.sample(10))
    elsif food == "k"
      user = User.find(user.id)
      user.print_recipes
    elsif food == "m"
      puts "\nCheating is not beneath you I see...."
      loading(60, ".")
      puts "\nVery well, then. ZOBOOMAFU!!"
      user = User.find(user.id)
      user.magic
    elsif food == "d"
      puts "Ohhh... what you dont have in your kitchen?"
      input = gets.chomp
      if user.get_ingredients_names.include?(input)
        user.remove_my_ingredient(input, user)
      else
        puts "Opps, you dont have that"
      end
    elsif Ingredient.get_ingredients_names.include?(food)
      user = User.find(user.id)
      user.add_ingredient(food)
      user.ingredients
      array = ["Really? #{food.capitalize}?! Okay....", "Wow, I love that too!", "No way, I just ran out of #{food}!", "My cat likes that! Great minds think alike, huh!", "We threw away a bag of #{food} this morning, I hope you didn't get ours...", "#{food.capitalize}! Sounds tasty!!!", "Oooooh! Experimenting I see!", "How are you possibly going to incorporate that into a dish? You don't even like #{food}!!", "Oh nice! #{user.username.capitalize}, I'm glad you're thinking healthy."]
      puts array.sample
    elsif food != "q"
      puts "Whoa, that's not an ingredient we have on record! Please try again!"
    end
  end
  system "clear" or system "cls"
  puts "Oh alright! So then..."
end

def cooking(user)
  system "clear" or system "cls"
  puts "So, you have your ingredients, yea?\n\nLet's find out what you can make..."
  sleep(1)
  puts "Sorting.... Processing...\n"
  sleep(1)
  puts "Ding, all sorted!"
  sleep(1)
  system "clear" or system "cls"
  user = User.find(user.id)
  user.get_recipes_i_can_make
  puts "Here's what you can cook!"
  puts "*" * 30
  user.list_complete_recipes
  puts "*" * 30
  puts ""
  puts "Oh, awesome! You can make all these recipes!\nThere are some other recipes that you are soooooo close to making; you only need to get a few more ingredients.\nWould you like get the link of a recipe, or check the incomplete ones?"
  input = ""
  while input != 'q'
    puts ""
    puts "Press the number of the recipe, or 'incomplete' for your list of recipes you can almost make, or 'q' to go to the main menu"
    input = gets.chomp
    # binding.pry
    if input == 'incomplete'
      puts "Huaaaa, good news, you only need a few more ingredients to make these recipes"
      puts "*" * 30
      puts user.list_incomplete_recipes
      puts "*" * 30
    elsif is_numeric?(input) && input.to_i <= user.complete_recipes.length && input != "0"
      index = input.to_i
      puts outputs_recipe_link(user, index)
    elsif input.to_i && input.to_i > user.complete_recipes.length
      puts "Oh, sorry, that's not a recipe you can make!"
    elsif input == 'q'
      return "Okay, cool"
    else
      puts "What's that, #{user.username.capitalize}? Speak louder!"
    end
  end
  puts "Okay then..."
  # current_user.list_incomplete_recipes
  #it goes back into the decision method. So we need to connect to a new method or break out of that one
end

def outputs_recipe_link(user, index)
  return user.complete_recipes[index-1]["recipe"].link
end

def is_numeric?(obj)
  obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
end

def functions(current_user)
  input = ""
  while input != "4"
    puts "\nHow can I help you?"
    total_rec = Recipe.all.length
    puts "Now with over #{total_rec - 1} recipes"
    puts "
    1) Check my Kitchen for Ingredients\n
    2) See what Recipes I can make\n
    3) Remove Myself from this confounded Program\n
    4) Exit the program\n "
    input = gets.chomp
    if input == "1"
      kitchen_query(current_user)
    elsif input == "2"
      cooking(current_user)
    elsif input == "3"
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
    elsif input == "4" || input == "quit"
      puts "Loud and clear! Until next time...."
      break

    elsif input == "secret"
      system "clear" or system "cls"
      loading(40, "*~")
      puts "\nENTERING DEV CONSOLE"
      puts "1) add recipes to system\n "
      puts "ENTER COMMAND\n "
      secret_input = gets.chomp
      if secret_input == "1"
        system "clear" or system "cls"
        puts "INPUT WHAT RECIPES YOU WOULD LIKE TO ADD"
        new_recipes = gets.chomp
        pull_recipes(new_recipes)
        add_ingredients
        map_recipe_with_ingredient(ALL_RECIPES)
        refresh1 = Recipe.find(1)
        refresh2 = Ingredient.find(1)
      end
    elsif input == "5"
      puts "This is an old functionality that I went in an added a secret message too! Good job!"
    else
      system "clear" or system "cls"
      random_array = ["Nice try, but not nice enough", "No way, Jose", "Not a valid command, dude", "Cool cool", "I'm excited for John's and Danny's program, no offense to anyone else...", "Did you hit F5? Because you refreshed this page!", "No, the links don't work, just copy and paste into your browser!", "Your name is #{User.all.sample.username}, right?"]
      puts random_array.sample
    end
  end
end
