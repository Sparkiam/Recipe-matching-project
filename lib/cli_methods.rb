def greeting
  puts "Welcome to Kitchen Helper!\nWe are your hosts: Yev and Jack!"
  # puts "~~~~~~\n~~~~~~\n~~~~~~"
  loading(get_random(5,12), "*", 0.3)
  loading(get_random(5,12), "*", 0.2)
  loading(get_random(5,12), "*", 0.1)
  puts "Please, tell us your name, kind one"
end

def loading(length, sym, timing)
  length.times do |a|
    print sym
    sleep(timing)
  end
  puts ""
end

def print_array(array)
  array.each_with_index do |item, i|
    puts "#{i+1}. #{item.capitalize}"
  end
end

def gathering_user_data(input)
  loading(15, "*", 0.1)
  system "clear" or system "cls"
  current_user = User.find_by("username = '#{input}'")
  if current_user
     puts "Oh, no, not you again..."
     sleep(1)
     puts "Well, #{input.capitalize}, we are here to give you a hand in your kitchen!"
  else
    current_user = User.create(:username => input)
    puts "#{input.capitalize}?! Can it really be you!?!!\n\nWelcome #{input.capitalize}"
    sleep(1)
    puts "Let's get some things set up."
    puts "\n*** - Normally it takes at least 10 ingredients to cook something.  - ***"
    puts "\n*** - Then go to the main menu to see what recipes you can make.    - ***"
    kitchen_query(current_user)
  end
  return current_user
end

def kitchen_query(user)
  puts "\nWhat food do you have in your kitchen?"
  puts "'q' - To go to the main menu\n'h' - For more options"
  puts "Type in what you have:\n "
  food = ""
  i = 0
  while food != "q"
    if i > 0
      puts "\nWhat else do you have in your kitchen?"
      if i > 3
        puts "'q' - To go to the main menu\n'h' - For more options"
      end
    end
    # i += 1
    food = gets.chomp.downcase.strip
    if food == "h"
      puts "\nSo, you need help?!\n'i' - For what you might have in your kitchen!\n'k' - To list what is already in your kitchen!\n'm' - To magically add food to your kitchen!\n'd' - To remove an item from your kitchen!\n'q' - To quit checking your kitchen!"
      i = 0
    elsif food == "i"
      puts "\nNeed help? Do you have any of these?"
      print_array(Ingredient.get_ingredients_names.sample(10))
    elsif food == "k"
      user = User.find(user.id)
      user.print_recipes
    elsif food == "m"
      puts "\nCheating is not beneath you I see...."
      loading(40, "*", 0.05)
      puts "\nVery well, then. ZOBOOMAFU!!"
      user = User.find(user.id)
      user.magic
      i += 1
    elsif food == "d"
      puts "Ohhh... what you dont have in your kitchen?"
      input = gets.chomp.downcase.strip
      if user.get_ingredients_names.include?(input)
        user.remove_my_ingredient(input, user)
      else
        puts "Opps, you dont have that"
      end
    elsif Ingredient.get_ingredients_names.include?(food)
      i += 1
      user = User.find(user.id)
      user.add_ingredient(food)
      user.ingredients
      array = ["Really? #{food.capitalize}?! Okay....", "Wow, I love that too!", "No way, I just ran out of #{food}!", "My cat likes that! Great minds think alike, huh!", "We threw away a bag of #{food} this morning, I hope you didn't get ours...", "#{food.capitalize}! Sounds tasty!!!", "Oooooh! Experimenting I see!", "How are you possibly going to incorporate that into a dish? You don't even like #{food}!!", "Oh nice! #{user.username.capitalize}, I'm glad you're thinking healthy."]
      puts array.sample
      sleep(1)
    elsif food != "q"
      puts "Whoa, that's not an ingredient we have on record! Please try again!"
      sleep(1)
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
  user = User.find(user.id)
  user.get_recipes_i_can_make
  system "clear" or system "cls"
  puts "Here's what you can cook!"
  sleep(0.05)
  loading(30, "*", 0.09)
  user.list_complete_recipes
  loading(30, "*", 0.09)
  puts ""
  if user.complete_recipes.length != 0
    puts "Oh, awesome! You can make all these recipes!\n "
    sleep(1)
    puts "Would you like get the link of a recipe, or check the incomplete ones?"
    sleep(1)
  end
  puts "There are some other recipes that you are soooooo close to making."
  sleep(1.5)
  puts "You only need to get a few more ingredients."
  sleep(1.5)
  input = ""
  while input != 'q'
    puts ""
    puts "'inc' - To list the recipes you can't make but you could if you had few more ingredients."
    puts "'q' - To go back to the main menu"
    if user.complete_recipes.length == 1
      puts "'1' - To get the link of that recipe"
    elsif user.complete_recipes.length == 0
      puts ""
    else
      complete_recipe_size = user.complete_recipes.length
      puts "'1-#{complete_recipe_size}' - To get a link of that recipe"
    end
    input = gets.chomp.downcase.strip
    # binding.pry
    if input == 'inc'
      puts "Huaaaa, good news, you only need a few more ingredients to make these recipes"
      puts "*" * 30
      puts user.list_incomplete_recipes
      puts "*" * 30
    elsif is_numeric?(input) && input.to_i <= user.complete_recipes.length && input != "0"
      index = input.to_i
      puts "\nHere is your link for #{user.complete_recipes[index-1]["recipe"].name}:"
      puts "Link: #{outputs_recipe_link(user, index)}"
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
    puts
    input = gets.chomp.downcase.strip
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
      loading(40, "*~", 0.1)
      puts "\nENTERING DEV CONSOLE"
      puts "1) add recipes to system\n "
      puts "ENTER COMMAND\n "
      secret_input = gets.chomp
      if secret_input == "1"
        system "clear" or system "cls"
        puts "INPUT WHAT RECIPES YOU WOULD LIKE TO ADD"
        new_recipes = gets.chomp.strip
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
