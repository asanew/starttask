# Числа Фибонначи

limit = 100

fib=[1,1]
loop do
  next_num = fib[-1]+fib[-2]
  if next_num > 100
    break
  end
  fib << next_num
end
puts "Числа Фибонначи до #{limit}:"
puts fib

