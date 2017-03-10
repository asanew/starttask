# Номер дня в году

#months={1 => 31,
#        2 => 28,
#        3 => 31,
#        4 => 30,
#        5 => 31,
#        6 => 30,
#        7 => 31,
#        8 => 31,
#        9 => 30,
#        10 => 31,
#        11 => 30,
#        12 => 31
#}

months = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

print "Введите день: "
day = gets.chomp.to_i

print "Введите номер месяца: "
month = gets.chomp.to_i

print "Введите год: "
year = gets.chomp.to_i

#year_day = 0
#cur_month = 1

if month > 2 && year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  months[1]+=1
end

#while cur_month < month do
#  year_day += months[cur_month]
#  if cur_month == 2 && year % 4 == 0 && year % 100 != 0 || year % 400 == 0
#      year_day += 1
#  end
#  cur_month += 1
#end

puts "Это день N #{months[0,month-1].sum + day} от начала года"

