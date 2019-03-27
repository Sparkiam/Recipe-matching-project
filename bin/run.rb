require_relative '../config/environment'

# puts "Yo dog, I heard you like ingredients. You can ingredient while you in ingredient so you can ingredient while you ingredient."

greeting

input = gets.chomp.downcase

current_user = gathering_user_data(input)

functions(current_user)
# 
#
#
# kitchen_query(current_user)
#
# puts "So that's your whoooooolllllleeeee kitchen, huh?"
# # sleep(1)
# puts "Are you ready to cook?\n1) 'Yes'\n2) 'Hold on, I've got more food!''\n3) 'I'm out, you are rude!'"
# decision(current_user)

#woudl you like to see the link? would you like to see the ingredients?
#what rcipe woudl you like to cook
