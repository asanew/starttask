# Идеальный вес

print "Введите свое имя: "
user_name=gets.chomp
user_name.capitalize!

print "Введите свой рост: "
user_height = gets.chomp.to_i

user_calculated_weight = user_height - 110

print "Привет, #{user_name}, "
if user_calculated_weight >= 0
	puts " Ваш идеальный вес: #{user_calculated_weight}"
else
	puts " Вы обладаете идеальным весом"
end

