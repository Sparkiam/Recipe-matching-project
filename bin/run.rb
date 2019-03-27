require_relative '../config/environment'

# puts "Yo dog, I heard you like ingredients. You can ingredient while you in ingredient so you can ingredient while you ingredient."

puts "Welcome to your nightmare!\nWe are your hosts: Yev and Jack!"
puts "~~~~~~\n~~~~~~\n~~~~~~"
# sleep(1)
puts "Please, tell us your name"
input = gets.chomp.downcase
current_user = User.find_or_create_by(:username => input)
puts "#{input.upcase}?! What a dumb name!!"
# sleep(1)
puts "Well, #{input.upcase}, I guess we could help you out!"
# sleep(1)
puts "So, tell us something..."

kitchen_query(current_user)

puts "So that's your whoooooolllllleeeee kitchen, huh?"
# sleep(1)
puts "Are you ready to cook?\n1) 'Yes'\n2) 'Hold on, I've got more food!''\n3)'I'm out, you are rude!'"
decision(current_user)
Í