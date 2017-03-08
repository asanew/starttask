# Заполнение массива числами с определенным шагом

start_val = 10
end_val = 100
step = 5

values = (start_val..end_val).step(step).to_a
puts "Массив от "+start_val.to_s+" до "+end_val.to_s+" с шагом "+step.to_s+":"
values.each do |val|
   print val.to_s+" "
end
puts
